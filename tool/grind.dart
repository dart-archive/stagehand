// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:ghpages_generator/ghpages_generator.dart' as ghpages;
import 'package:grinder/grinder.dart';
import 'package:path/path.dart' as path;
import 'package:stagehand/stagehand.dart' as stagehand;
import 'package:yaml/yaml.dart' as yaml;

final RegExp _binaryFileTypes = new RegExp(
    r'\.(jpe?g|png|gif|ico|svg|ttf|eot|woff|woff2)$', caseSensitive: false);

main([List<String> args]) => grind(args);

@Task('Concatenate the template files into data files that the generators can consume')
void build() {
  stagehand.generators.forEach((generator) {
    _concatenateFiles(
        getDir('templates/${generator.id}'),
        getFile('lib/generators/${generator.id.replaceAll('-', '_')}_data.dart'));
  });

  // Update the readme.md file.
  File f = getFile('README.md');
  String source = f.readAsStringSync();
  String fragment = stagehand.generators.map((g) {
    return '* `${g.id}` - ${g.description}';
  }).join('\n');
  String newSource = _replaceInString(
      source,
      '## Stagehand templates',
      '## Installation',
      fragment + '\n');
  f.writeAsStringSync(newSource);

  // Update the site/index.html file.
  f = getFile('site/index.html');
  source = f.readAsStringSync();
  fragment = stagehand.generators.map((g) {
    return '  <li>${g.id} - <em>${g.description}</em></li>';
  }).join('\n');
  newSource = _replaceInString(
      source,
      '<ul id="template-list">',
      '</ul>',
      fragment);
  f.writeAsStringSync(newSource);
}

@Task('Generate a new version of gh-pages')
void updateGhPages() {
  log('Updating gh-pages branch of the project');
  new ghpages.Generator(rootDir: getDir('.').absolute.path)
    ..templateDir = getDir('site').absolute.path
    ..generate();
}

@Task('Run each generator and analyze the output')
void test() {
  for (stagehand.Generator generator in stagehand.generators) {
    Directory dir = Directory.systemTemp.createTempSync('stagehand.test.');
    try {
      _testGenerator(generator, dir);
    } finally {
      dir.deleteSync(recursive: true);
    }
  }
}

void _testGenerator(stagehand.Generator generator, Directory tempDir) {
  log('');
  log('${generator.id} template:');

  Dart.run(path.join(path.current, 'bin/stagehand.dart'),
      arguments: ['--mock-analytics', generator.id],
      workingDirectory: tempDir.path);

  var pubspecPath = path.join(tempDir.path, 'pubspec.yaml');
  var pubspecFile = new File(pubspecPath);

  if (!pubspecFile.existsSync()) {
    throw 'A pubspec much be defined!';
  }

  run('pub', arguments: ['get'], workingDirectory: tempDir.path);

  var filePath = path.join(tempDir.path, generator.entrypoint.path);

  if (path.extension(filePath) != '.dart' ||
      !FileSystemEntity.isFileSync(filePath)) {
    var parent = new Directory(path.dirname(filePath));

    var file = _listSync(parent).firstWhere((f) => f.path.endsWith('.dart'),
        orElse: () => null);

    if (file == null) {
      filePath = null;
    } else {
      filePath = file.path;
    }
  }

  // Run the analyzer.
  if (filePath != null) {
    Analyzer.analyze(filePath, fatalWarnings: true,
        packageRoot: new Directory(path.join(tempDir.path, 'packages')));
  }

  // Run package tests, if `test` is included.
  var pubspecContent = yaml.loadYaml(pubspecFile.readAsStringSync());
  var devDeps = pubspecContent['dev_dependencies'];
  if (devDeps != null && devDeps.containsKey('test')) {
    new PubApp.local('test').run([], workingDirectory: tempDir.path);
  }
}

void _concatenateFiles(Directory src, File target) {
  log('Creating ${target.path}');

  List<String> results = [];

  _traverse(src, '', results);

  String str = results.map((s) => '  ${_toStr(s)}').join(',\n');

  target.writeAsStringSync("""
// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

List<String> data = [
${str}
];
""");
}

String _toStr(String s) {
  if (s.contains('\n')) {
    return '"""${s}"""';
  } else {
    return '"${s}"';
  }
}

void _traverse(Directory dir, String root, List<String> results) {
  var files = _listSync(dir, recursive: false, followLinks: false);
  for (FileSystemEntity entity in files) {
    String name = path.basename(entity.path);

    if (entity is Link) continue;

    if (name == 'pubspec.lock') continue;
    if (name.startsWith('.') && name != '.gitignore') continue;

    if (entity is Directory) {
      _traverse(entity, '${root}${name}/', results);
    } else {
      File file = entity;
      String fileType = _isBinaryFile(name) ? 'binary' : 'text';
      String data = CryptoUtils.bytesToBase64(file.readAsBytesSync(),
          addLineSeparator: true);

      results.add('${root}${name}');
      results.add(fileType);
      results.add(data);
    }
  }
}

/**
 * Returns true if the given [filename] matches common image file name patterns.
 */
bool _isBinaryFile(String filename) => _binaryFileTypes.hasMatch(filename);

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

/// Look for [start] and [end] in [source]; replace the current contents with
/// [replacement], and return the result.
String _replaceInString(String source, String start,
    String end, String replacement) {
  int startIndex = source.indexOf(start);
  int endIndex = source.indexOf(end, startIndex + 1);

  if (startIndex == -1 || endIndex == -1) {
    fail('Could not find text to replace');
  }

  return source.substring(0, startIndex + start.length + 1) +
      replacement +
      '\n' +
      source.substring(endIndex);
}
