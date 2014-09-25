// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:ghpages_generator/ghpages_generator.dart' as ghpages;
import 'package:grinder/grinder.dart';
import 'package:grinder/grinder_utils.dart' show PubTools;
import 'package:path/path.dart' as path;

final Directory BUILD_DIR = new Directory('build');

final RegExp _binaryFileTypes = new RegExp(
    r'\.(jpe?g|png|gif|ico|svg|ttf|eot|woff|woff2)$', caseSensitive: false);

void main([List<String> args]) {
  task('init', init);
  task('build-examples', buildExamples, ['init']);
  task('update-gh-pages', updateGhPages, ['init']);
  task('clean', clean);

  startGrinder(args);
}

/**
 * Do any necessary build set up.
 */
void init(GrinderContext context) {
  // Verify we're running in the project root.
  if (!getDir('lib').existsSync() || !getFile('pubspec.yaml').existsSync()) {
    context.fail('This script must be run from the project root.');
  }
}

/**
 * Concatenate the template files into data files that the generators can
 * consume.
 */
void buildTemplates(GrinderContext context) {
  // TODO: Test the generation - generate the code on the bots and analyze it.

  // Build the helloworld example.
  _concatenateFiles(
      context,
      getDir('templates/helloworld'),
      getFile('lib/generators/helloworld_data.dart'));

  // Build WSK.
  _concatenateFiles(
      context,
      getDir('templates/webstarterkit'),
      getFile('lib/generators/webstarterkit_data.dart'));
}

/**
 * Generate a new version of gh-pages.
 */
void updateGhPages(GrinderContext context) {
  context.log('Updating gh-pages branch of the project');
  new ghpages.Generator(rootDir: getDir('.').absolute.path)
      ..templateDir = getDir('site/build/web').absolute.path
      ..generate();
}

/**
 * Delete all generated artifacts.
 */
void clean(GrinderContext context) {
  // Delete the build/ dir.
  deleteEntity(BUILD_DIR, context);
}

void _concatenateFiles(GrinderContext context, Directory src, File target) {
  context.log('Creating ${target.path}');

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
  for (FileSystemEntity entity in dir.listSync(recursive: false, followLinks: false)) {
    String name = path.basename(entity.path);

    if (entity is Link) {
      continue;
    } else if (entity is Directory) {
      _traverse(entity, '${root}${name}/', results);
    } else {
      File file = entity;
      String fileType = _isBinaryFile(name) ? 'binary' : 'text';
      String data = CryptoUtils.bytesToBase64(
          file.readAsBytesSync(), addLineSeparator: true);

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

