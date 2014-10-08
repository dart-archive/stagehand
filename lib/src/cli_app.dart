// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library stagehand.cli_app;

import 'dart:async';
import 'dart:convert' show JSON;
import 'dart:io' as io;
import 'dart:math';

import 'package:args/args.dart';
import 'package:path/path.dart' as path;
import 'package:stagehand/stagehand.dart';
import 'package:stagehand/analytics/analytics_io.dart';
import 'package:stagehand/src/common.dart';

const String APP_NAME = 'stagehand';
const String APP_VERSION = '0.0.5-dev';

// The Google Analytics tracking ID for stagehand.
const String _GA_TRACKING_ID = 'UA-55033590-1';

class CliApp {
  final List<Generator> generators;
  final CliLogger logger;

  GeneratorTarget target;
  Analytics analytics;

  CliApp(this.generators, this.logger, [this.target]) {
    assert(generators != null);
    assert(logger != null);

    analytics = new AnalyticsIO(_GA_TRACKING_ID, APP_NAME, APP_VERSION);

    generators.sort(Generator.compareGenerators);
  }

  Future process(List<String> args) {
    ArgParser argParser = _createArgParser();

    ArgResults options;

    try {
      options = argParser.parse(args);
    } catch (e, st) {
      // FormatException: Could not find an option named "foo".
      if (e is FormatException) {
        _out('Error: ${e.message}');
        return new Future.error(new ArgError(e.message));
      } else {
        return new Future.error(e, st);
      }
    }

    if (!analytics.enablementExplicitlyChanged) {
      analytics.disabled = false;
    }

    if (options.wasParsed('analytics')) {
      analytics.disabled = !options['analytics'];
      analytics.sendScreenView('analytics');
      _out("Analytics ${analytics.disabled ? 'disabled' : 'enabled'}.");
      return new Future.value();
    }

    // This hidden option is used so that our build bots don't send emit data.
    if (options['mock-analytics']) {
      analytics = new AnalyticsMock();
    }

    // The `--machine` option emits the list of available generators to stdout
    // as Json. This is useful for tools that don't want to have to parse the
    // output of `--help`. It's an undocumented command line flag, and may go
    // away or change.
    if (options['machine']) {
      analytics.sendScreenView('machine');
      Iterable itor = generators.map((generator) =>
          {'name': generator.id, 'description': generator.description});
      logger.stdout(JSON.encode(itor.toList()));
      return new Future.value();
    }

    if (options['help'] || args.isEmpty) {
      _out("Welcome to Stagehand! We collect anonymous usage statistics and crash reports in order");
      _out("to improve the tool (http://goo.gl/6wsncI). Run 'stagehand --no-analytics' to opt-out.");
      _out('');

      analytics.sendScreenView(options['help'] ? 'help' : 'main');
      _usage(argParser);
      return new Future.value();
    }

    if (options.rest.isEmpty) {
      logger.stderr("No generator specified.\n");
      _usage(argParser);
      return new Future.error(new ArgError('no generator specified'));
    }

    if (options.rest.length >= 2) {
      logger.stderr("Error: too many arguments given.\n");
      _usage(argParser);
      return new Future.error(new ArgError('invalid generator'));
    }

    String generatorName = options.rest.first;
    Generator generator = _getGenerator(generatorName);

    if (generator == null) {
      logger.stderr("'${generatorName}' is not a valid generator.\n");
      _usage(argParser);
      return new Future.error(new ArgError('invalid generator'));
    }

    String outputDir = options['outdir'];

    if (outputDir == null) {
      logger.stderr("No output directory specified.\n");
      _usage(argParser);
      return new Future.error(new ArgError('No output directory specified'));
    }

    io.Directory dir = new io.Directory(outputDir);

    if (dir.existsSync()) {
      logger.stderr("Error: '${dir.path}' already exists.\n");
      return new Future.error(new ArgError('target path already exists'));
    }

    // Validate and normalize the project name.
    String projectName = path.basename(dir.path);
    if (_validateName(projectName) != null) {
      logger.stderr(_validateName(projectName));
      return new Future.error(new ArgError(_validateName(projectName)));
    }
    projectName = normalizeProjectName(projectName);

    if (target == null) {
      target = new _DirectoryGeneratorTarget(logger, dir);
    }

    _out("Creating ${generatorName} application '${projectName}':");

    analytics.sendScreenView('create');
    analytics.sendEvent('create', generatorName, generator.description);

    return generator.generate(projectName, target).then((_) {
      _out("${generator.numFiles()} files written.");
    });
  }

  ArgParser _createArgParser() {
    var argParser = new ArgParser();

    argParser.addOption('outdir', abbr: 'o', valueHelp: 'path',
        help: 'Where to put the files.');
    argParser.addFlag('help', abbr: 'h', negatable: false,
        help: 'Help!');
    argParser.addFlag('analytics', negatable: true,
        help: 'Opt-out of anonymous usage and crash reporting.');
    argParser.addFlag('machine', negatable: false, hide: true);
    argParser.addFlag('mock-analytics', negatable: false, hide: true);

    return argParser;
  }

  String _validateName(String projectName) {
    if (projectName.contains(' ')) {
      return "The project name cannot contain spaces.";
    }

    if (!projectName.startsWith(new RegExp(r'[A-Za-z]'))) {
      return "The project name must start with a letter.";
    }

    // Project name is valid.
    return null;
  }

  void _usage(ArgParser argParser) {
    _out('usage: ${APP_NAME} -o <output directory> generator-name');
    _out(argParser.getUsage());
    _out('');
    _out('Available generators:\n');
    int len = generators
      .map((g) => g.id.length)
      .fold(0, (a, b) => max(a, b));
    generators
      .map((g) {
        var lines = wrap(g.description, 78 - len);
        var desc = lines.first;
        if (lines.length > 1) {
          desc += '\n' +
            lines.sublist(1, lines.length)
              .map((line) => '${_pad(' ', len + 2)}$line')
              .join('\n');
        }
        return "${_pad(g.id, len)}: ${desc}";
      })
      .forEach(logger.stdout);
  }

  Generator _getGenerator(String id) {
    return generators.firstWhere((g) => g.id == id, orElse: () => null);
  }

  void _out(String str) => logger.stdout(str);
}

class ArgError implements Exception {
  final String message;
  ArgError(this.message);
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

  Future createFile(String filePath, List<int> contents) {
    io.File file = new io.File(path.join(dir.path, filePath));

    logger.stdout('  ${file.path}');

    return file
      .create(recursive: true)
      .then((_) => file.writeAsBytes(contents));
  }
}

String _pad(String str, int len) {
  while (str.length < len) str += ' ';
  return str;
}
