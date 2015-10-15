// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// This is explicitly not named with _test.dart extension so it is not run as
// part of the normal test process
@TestOn('vm')
library stagehand.test.validate_templates;

import 'dart:io';

import 'package:grinder/grinder.dart';
import 'package:path/path.dart' as path;
import 'package:stagehand/stagehand.dart' as stagehand;
import 'package:test/test.dart';
import 'package:yaml/yaml.dart' as yaml;

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

  for (stagehand.Generator generator in stagehand.generators) {
    test(generator.id, () {
      _testGenerator(generator, dir);
    });
  }
}

void _testGenerator(stagehand.Generator generator, Directory tempDir) {
  Dart.run(path.join(path.current, 'bin/stagehand.dart'),
      arguments: ['--mock-analytics', generator.id],
      runOptions: new RunOptions(workingDirectory: tempDir.path));

  var pubspecPath = path.join(tempDir.path, 'pubspec.yaml');
  var pubspecFile = new File(pubspecPath);

  if (!pubspecFile.existsSync()) {
    throw 'A pubspec much be defined!';
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
    String packagesDir = path.join(tempDir.path, 'packages');

    Analyzer.analyze(filePath,
        fatalWarnings: true, packageRoot: new Directory(packagesDir));
  }

  // Run package tests, if `test` is included.
  var pubspecContent = yaml.loadYaml(pubspecFile.readAsStringSync());
  var devDeps = pubspecContent['dev_dependencies'];
  if (devDeps != null) {
    if (devDeps.containsKey('test')) {
      Pub.run('test',
          runOptions: new RunOptions(workingDirectory: tempDir.path));
    }
  }
}

/**
 * Return the list of children for the given directory. This list is normalized
 * (by sorting on the file path) in order to prevent large merge diffs in the
 * generated template data files.
 */
List<FileSystemEntity> _listSync(Directory dir,
    {bool recursive: false, bool followLinks: true}) {
  List<FileSystemEntity> results =
      dir.listSync(recursive: recursive, followLinks: followLinks);
  results.sort((entity1, entity2) => entity1.path.compareTo(entity2.path));
  return results;
}
