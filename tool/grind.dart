// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:ghpages_generator/ghpages_generator.dart' as ghpages;
import 'package:grinder/grinder.dart';
import 'package:path/path.dart' as path;
import 'package:stagehand/stagehand.dart' as stagehand;

const List<String> _allowedDotFiles = const <String>['.gitignore'];

final RegExp _binaryFileTypes = new RegExp(
    r'\.(jpe?g|png|gif|ico|svg|ttf|eot|woff|woff2)$',
    caseSensitive: false);

main(List<String> args) => grind(args);

@Task('Concatenate the template files into runtime data files')
void build() {
  stagehand.generators.forEach((generator) {
    _concatenateFiles(
        getDir('templates/${generator.id}'),
        getFile(
            'lib/generators/${generator.id.replaceAll('-', '_')}_data.dart'));
  });

  // Update the readme.md file.
  File f = getFile('README.md');
  String source = f.readAsStringSync();
  String fragment = stagehand.generators.map((g) {
    return '* `${g.id}` - ${g.description}';
  }).join('\n');
  String newSource = _replaceInString(
      source, '## Stagehand templates', '## Installation', fragment + '\n');
  f.writeAsStringSync(newSource);

  // Update the site/index.html file.
  f = getFile('site/index.html');
  source = f.readAsStringSync();
  fragment = stagehand.generators.map((g) {
    return '  <li>${g.id} - <em>${g.description}</em></li>';
  }).join('\n');
  newSource =
      _replaceInString(source, '<ul id="template-list">', '</ul>', fragment);
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
test() => new TestRunner().testAsync(files: 'test/validate_templates.dart');

void _concatenateFiles(Directory src, File target) {
  log('Creating ${target.path}');

  String str = _traverse(src, '').map((s) => '  ${_toStr(s)}').join(',\n');

  target.writeAsStringSync('''
// Copyright (c) ${_currentYear()}, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

const List<String> data = const [
$str
];
''');
}

String _toStr(String s) {
  if (s.contains('\n')) {
    return "'''$s'''";
  } else {
    return "'$s'";
  }
}

Iterable<String> _traverse(Directory dir, String root) sync* {
  var files = _listSync(dir, recursive: false, followLinks: false);
  for (FileSystemEntity entity in files) {
    if (entity is Link) continue;

    String name = path.basename(entity.path);
    if (name == 'pubspec.lock') continue;
    if (name == 'build' && entity is Directory) continue;
    if (name.startsWith('.') && !_allowedDotFiles.contains(name)) continue;

    if (entity is Directory) {
      yield* _traverse(entity, '$root$name/');
    } else {
      yield '$root$name';
      yield _isBinaryFile(name) ? 'binary' : 'text';

      var encoded = BASE64.encode((entity as File).readAsBytesSync());

      //
      // Logic to cut lines into 76-character chunks
      // – makes for prettier source code
      //
      var lines = <String>[];
      var index = 0;

      while (index < encoded.length) {
        var line =
            encoded.substring(index, math.min(index + 76, encoded.length));
        lines.add(line);
        index += line.length;
      }

      yield lines.join('\r\n');
    }
  }
}

/// Returns `true` if the given [filename] matches common image file name
/// patterns.
bool _isBinaryFile(String filename) => _binaryFileTypes.hasMatch(filename);

/// Return the list of children for the given directory.
///
/// This list is normalized (by sorting on the file path) in order to prevent
/// large merge diffs in the generated template data files.
List<FileSystemEntity> _listSync(Directory dir,
    {bool recursive: false, bool followLinks: true}) {
  List<FileSystemEntity> results =
      dir.listSync(recursive: recursive, followLinks: followLinks);
  results.sort((entity1, entity2) => entity1.path.compareTo(entity2.path));
  return results;
}

/// Look for [start] and [end] in [source]; replace the current contents with
/// [replacement], and return the result.
String _replaceInString(
    String source, String start, String end, String replacement) {
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

int _currentYear() => new DateTime.now().year;
