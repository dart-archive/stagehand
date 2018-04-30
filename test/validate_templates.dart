// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// This is explicitly not named with _test.dart extension so it is not run as
// part of the normal test process
@TestOn('vm')
import 'dart:io';

import 'package:grinder/grinder.dart' hide fail;
import 'package:path/path.dart' as path;
import 'package:stagehand/stagehand.dart' as stagehand;
import 'package:test/test.dart';
import 'package:yaml/yaml.dart' as yaml;

final _pubspecOrder = const [
  'name',
  'description',
  'version',
  'homepage',
  'author(s)?',
  'environment',
  'dependencies',
  'dev_dependencies'
];

final List<RegExp> _pubspecOrderRegexps = _pubspecOrder
    .map((s) => new RegExp('^(# *)?$s:', multiLine: true))
    .toList();

final String _expectedGitIgnore = _getMetaTemplateFile('.gitignore');
final String _expectedAnalysisOptions =
    _getMetaTemplateFile('templates/analysis_options.yaml');
final String _expectedAngularAnalysisOptions = [
  _expectedAnalysisOptions.split('\n').take(2),
  '  errors:',
  '    uri_has_not_been_generated: ignore',
  '  plugins:',
  '    - angular',
  _expectedAnalysisOptions.split('\n').skip(4),
].expand((e) => e is Iterable ? e : [e]).join('\n');

void main() {
  Directory dir;

  setUp(() async {
    dir = await Directory.systemTemp.createTemp('stagehand.test.');
  });

  tearDown(() async {
    if (dir != null) {
      await dir.delete(recursive: true);
    }
  });

  test('Meta-template .gitignore exists',
      () => expect(_expectedGitIgnore, isNotEmpty));

  test('Meta-template analysis_options.yaml exists',
      () => expect(_expectedAnalysisOptions, isNotEmpty));

  test('Validate pkg/stagehand pubspec', () {
    var pubspecContent =
        new File(path.join(path.current, 'pubspec.yaml')).readAsStringSync();
    _validatePubspec(pubspecContent);
  });

  for (var generator in stagehand.generators) {
    test(generator.id, () {
      _testGenerator(generator, dir);
    });
  }
}

void _testGenerator(stagehand.Generator generator, Directory tempDir) {
  Dart.run(path.join(path.current, 'bin/stagehand.dart'),
      vmArgs: ['--preview-dart-2'],
      arguments: ['--mock-analytics', generator.id],
      runOptions: new RunOptions(workingDirectory: tempDir.path));

  var gitIgnorePath = path.join(tempDir.path, '.gitignore');
  var gitIgnoreFile = new File(gitIgnorePath);

  expect(gitIgnoreFile.readAsStringSync(), _expectedGitIgnore,
      reason: 'Expected all of the .gitignore files to be identical.');

  var pubspecPath = path.join(tempDir.path, 'pubspec.yaml');
  var pubspecFile = new File(pubspecPath);
  var pubspecContentString = pubspecFile.readAsStringSync();
  var pubspecContent = yaml.loadYaml(pubspecContentString) as yaml.YamlMap;
  final usesAngular =
      pubspecContent['dependencies']?.containsKey('angular') ?? false;

  var analysisOptionsPath = path.join(tempDir.path, 'analysis_options.yaml');
  var analysisOptionsFile = new File(analysisOptionsPath);
  expect(analysisOptionsFile.readAsStringSync(),
      usesAngular ? _expectedAngularAnalysisOptions : _expectedAnalysisOptions,
      reason: 'All analysis_options.yaml files should be identical.');

  if (!pubspecFile.existsSync()) {
    fail('A pubspec must be defined!');
  }

  Pub.get(runOptions: new RunOptions(workingDirectory: tempDir.path));

  var filePath = path.join(tempDir.path, generator.entrypoint.path);

  if (path.extension(filePath) != '.dart' ||
      !FileSystemEntity.isFileSync(filePath)) {
    var parent = new Directory(path.dirname(filePath));

    var file = _listSync(parent)
        .firstWhere((f) => f.path.endsWith('.dart'), orElse: () => null);

    if (file == null) {
      filePath = null;
    } else {
      filePath = file.path;
    }
  }

  // Run the analyzer.
  if (filePath != null) {
    var cwd = Directory.current;
    try {
      // TODO: Extend Analyzer.analyze to support .packages files.
      Directory.current = tempDir.path;
      Analyzer.analyze(filePath, fatalWarnings: true);
    } finally {
      Directory.current = cwd;
    }
  }

  //
  // validate pubspec values
  //
  _validatePubspec(pubspecContentString);

  expect(pubspecContent, containsPair('name', 'stagehand'));
  expect(pubspecContent, containsPair('description', isNotEmpty));

  final minSDK = '2.0.0-dev.48.0';
  final env = {'sdk': '>=$minSDK <2.0.0'};
  expect(pubspecContent, containsPair('environment', env));

  // Run package tests, if `test` is included.
  var devDeps = pubspecContent['dev_dependencies'];
  if (devDeps != null) {
    if (devDeps.containsKey('test')) {
      Pub.run('test',
          runOptions: new RunOptions(workingDirectory: tempDir.path));
    }
  }
}

void _validatePubspec(String pubspecContentString) {
  // Note: the regex will match lines even if they are commented out
  var orders = _pubspecOrderRegexps
      .map((regexp) => pubspecContentString.indexOf(regexp))
      .toList();

  // On failure, you'll just see numbers – but the `reason` will help understand
  // which order things should go in.
  expect(orders, orderedEquals(orders.toList()..sort()),
      reason:
          "Top-level keys in the pubspec were not in the expected order: ${_pubspecOrder.join(',')}");
}

/// Return the list of children for the given directory. This list is normalized
/// (by sorting on the file path) in order to prevent large merge diffs in the
/// generated template data files.
List<FileSystemEntity> _listSync(Directory dir,
    {bool recursive: false, bool followLinks: true}) {
  var results = dir.listSync(recursive: recursive, followLinks: followLinks);
  results.sort((entity1, entity2) => entity1.path.compareTo(entity2.path));
  return results;
}

// Gets the named meta-template file if available, returns '' otherwise.
String _getMetaTemplateFile(String fileName) {
  try {
    return new File(path.join(path.current, fileName)).readAsStringSync();
  } on FileSystemException catch (_) {
    return '';
  }
}
