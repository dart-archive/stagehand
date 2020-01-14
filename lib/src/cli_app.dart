// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'dart:math';

import 'package:args/args.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:pedantic/pedantic.dart';
import 'package:stagehand/src/common.dart';
import 'package:stagehand/stagehand.dart';
import 'package:usage/usage_io.dart';

import 'version.dart';

const String appName = 'stagehand';

const String appPubInfo = 'https://pub.dev/packages/$appName.json';

// The Google Analytics tracking ID for stagehand.
const String _gaTrackingId = 'UA-26406144-31';

class CliApp {
  static final Duration _timeout = const Duration(milliseconds: 500);

  final List<Generator> generators;
  final CliLogger logger;

  GeneratorTarget target;
  Analytics analytics;
  io.Directory _cwd;
  bool _firstScreen = true;

  CliApp(this.generators, this.logger, [this.target]) {
    assert(generators != null);
    assert(logger != null);

    analytics = AnalyticsIO(_gaTrackingId, appName, packageVersion)
      // These `cdX` values MUST be tightly coordinated with Analytics config
      // DO NOT modify unless you're certain what you're doing.
      // Contact kevmoo@ if you have questions
      ..setSessionValue('cd1', io.Platform.operatingSystem)
      ..setSessionValue('cd3', io.Platform.version.split(' ').first);

    generators.sort();
  }

  io.Directory get cwd => _cwd ?? io.Directory.current;

  /// An override for the directory to generate into; public for testing.
  set cwd(io.Directory value) {
    _cwd = value;
  }

  Future process(List<String> args) async {
    var argParser = _createArgParser();

    ArgResults options;

    try {
      options = argParser.parse(args);
    } catch (e, st) {
      // FormatException: Could not find an option named "foo".
      if (e is FormatException) {
        _out('Error: ${e.message}');
        return Future.error(ArgError(e.message));
      } else {
        return Future.error(e, st);
      }
    }

    if (options.wasParsed('analytics')) {
      analytics.enabled = options['analytics'];
      _out("Analytics ${analytics.enabled ? 'enabled' : 'disabled'}.");
      if (analytics.enabled) unawaited(analytics.sendScreenView('analytics'));
      return analytics.waitForLastPing(timeout: _timeout);
    }

    // This hidden option is used so that our build bots don't emit data.
    if (options['mock-analytics']) {
      analytics = AnalyticsMock();
    }

    if (options['version']) {
      _out('$appName version: $packageVersion');
      return http.get(appPubInfo).then((response) {
        List versions = jsonDecode(response.body)['versions'];
        if (packageVersion != versions.last) {
          _out('Version ${versions.last} is available! Run `pub global activate'
              ' $appName` to get the latest.');
        }
      }).catchError((e) => null);
    }

    if (options['help'] || args.isEmpty) {
      // Prompt to opt into advanced analytics.
      if (analytics.firstRun) {
        _out('''
Welcome to Stagehand! We collect anonymous usage statistics and crash reports in
order to improve the tool (http://goo.gl/6wsncI). Would you like to opt-in to
additional analytics to help us improve Stagehand [y/yes/no]?''');
        await io.stdout.flush();
        var response = io.stdin.readLineSync();
        response = response.toLowerCase().trim();
        analytics.enabled = (response == 'y' || response == 'yes');
        _out('');
      }

      _screenView(options['help'] ? 'help' : 'main');
      _usage(argParser);
      return analytics.waitForLastPing(timeout: _timeout);
    }

    // The `--machine` option emits the list of available generators to stdout
    // as JSON. This is useful for tools that don't want to have to parse the
    // output of `--help`. It's an undocumented command line flag, and may go
    // away or change.
    if (options['machine']) {
      _screenView('machine');
      logger.stdout(_createMachineInfo(generators));
      return analytics.waitForLastPing(timeout: _timeout);
    }

    if (options.rest.isEmpty) {
      logger.stderr('No generator specified.\n');
      _usage(argParser);
      return Future.error(ArgError('no generator specified'));
    }

    if (options.rest.length >= 2) {
      logger.stderr('Error: too many arguments given.\n');
      _usage(argParser);
      return Future.error(ArgError('invalid generator'));
    }

    var generatorName = options.rest.first;
    var generator = _getGenerator(generatorName);

    if (generator == null) {
      logger.stderr("'$generatorName' is not a valid generator.\n");
      _usage(argParser);
      return Future.error(ArgError('invalid generator'));
    }

    var dir = cwd;

    if (!options['override'] && !await _isDirEmpty(dir)) {
      logger.stderr(
          'The current directory is not empty. Please create a new project directory, or '
          'use --override to force generation into the current directory.');
      return Future.error(ArgError('project directory not empty'));
    }

    // Normalize the project name.
    var projectName = path.basename(dir.path);
    projectName = normalizeProjectName(projectName);

    target ??= _DirectoryGeneratorTarget(logger, dir);

    _out('Creating $generatorName application `$projectName`:');

    _screenView('create');
    unawaited(analytics.sendEvent('create', generatorName,
        label: generator.description));

    String author = options['author'];

    if (!options.wasParsed('author')) {
      try {
        var result = io.Process.runSync('git', ['config', 'user.name']);
        if (result.exitCode == 0) author = result.stdout.trim();
      } catch (exception) {
        // NOOP
      }
    }

    var email = 'email@example.com';

    try {
      var result = io.Process.runSync('git', ['config', 'user.email']);
      if (result.exitCode == 0) email = result.stdout.trim();
    } catch (exception) {
      // NOOP
    }

    var vars = {'author': author, 'email': email};

    var f = generator.generate(projectName, target, additionalVars: vars);
    return f.then((_) {
      _out('${generator.numFiles()} files written.');

      var message = generator.getInstallInstructions();
      if (message != null && message.isNotEmpty) {
        message = message.trim();
        message = message.split('\n').map((line) => '--> $line').join('\n');
        _out('\n$message');
      }
    }).then((_) {
      return analytics.waitForLastPing(timeout: _timeout);
    });
  }

  ArgParser _createArgParser() {
    var argParser = ArgParser();

    argParser.addFlag('analytics',
        negatable: true,
        help: 'Opt out of anonymous usage and crash reporting.');
    argParser.addFlag('help', abbr: 'h', negatable: false, help: 'Help!');
    argParser.addFlag('version',
        negatable: false, help: 'Display the version for $appName.');
    argParser.addOption('author',
        defaultsTo: '<your name>',
        help: 'The author name to use for file headers.');

    // Really, really generate into the current directory.
    argParser.addFlag('override', negatable: false, hide: true);

    // Output the list of available projects as JSON to stdout.
    argParser.addFlag('machine', negatable: false, hide: true);

    // Mock out analytics - for use on our testing bots.
    argParser.addFlag('mock-analytics', negatable: false, hide: true);

    return argParser;
  }

  String _createMachineInfo(List<Generator> generators) {
    var itor = generators.map((Generator generator) {
      var m = {
        'name': generator.id,
        'label': generator.label,
        'description': generator.description,
        'categories': generator.categories
      };

      if (generator.entrypoint != null) {
        m['entrypoint'] = generator.entrypoint.path;
      }

      return m;
    });
    return json.encode(itor.toList());
  }

  void _usage(ArgParser argParser) {
    _out(
        'Stagehand will generate the given application type into the current directory.');
    _out('');
    _out('usage: $appName <generator-name>');
    _out(argParser.usage);
    _out('');
    _out('Available generators:');
    var len = generators.fold(0, (int length, g) => max(length, g.id.length));
    generators
        .map((g) => '  ${g.id.padRight(len)} - ${g.description}')
        .forEach(logger.stdout);
  }

  Generator _getGenerator(String id) {
    return generators.firstWhere((g) => g.id == id, orElse: () => null);
  }

  void _out(String str) => logger.stdout(str);

  void _screenView(String view) {
    // If the user hasn't opted in, only send a version check - no page data.
    if (!analytics.enabled) view = 'main';

    Map<String, String> params;
    if (_firstScreen) {
      params = {'sc': 'start'};
      _firstScreen = false;
    }
    analytics.sendScreenView(view, parameters: params);
  }

  /// Returns true if the given directory does not contain non-symlinked,
  /// non-hidden subdirectories.
  static Future<bool> _isDirEmpty(io.Directory dir) async {
    var isHiddenDir = (dir) => path.basename(dir.path).startsWith('.');

    return dir
        .list(followLinks: false)
        .where((entity) => entity is io.Directory)
        .where((entity) => !isHiddenDir(entity))
        .isEmpty;
  }
}

class ArgError implements Exception {
  final String message;
  ArgError(this.message);

  @override
  String toString() => message;
}

class CliLogger {
  void stdout(String message) => print(message);
  void stderr(String message) => print(message);
}

class _DirectoryGeneratorTarget extends GeneratorTarget {
  final CliLogger logger;
  final io.Directory dir;

  _DirectoryGeneratorTarget(this.logger, this.dir) {
    dir.createSync();
  }

  @override
  Future createFile(String filePath, List<int> contents) {
    var file = io.File(path.join(dir.path, filePath));

    logger.stdout('  ${file.path}');

    return file
        .create(recursive: true)
        .then((_) => file.writeAsBytes(contents));
  }
}
