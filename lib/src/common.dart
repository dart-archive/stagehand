// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/**
 * Some utility methods for stagehand.
 */
library stagehand.utils;

import 'dart:convert' show UTF8;

import 'package:crypto/crypto.dart';

import '../stagehand.dart';

const int _RUNE_SPACE = 32;

final _substitueRegExp = new RegExp(r'__([a-zA-Z]+)__');
final _nonValidSubstitueRegExp = new RegExp(r'\W');

Iterable<TemplateFile> decodeConcatenatedData(List<String> data) sync* {
  for (int i = 0; i < data.length; i += 3) {
    String path = data[i];
    String type = data[i + 1];
    String raw = data[i + 2];

    List<int> decoded = CryptoUtils.base64StringToBytes(raw);

    if (type == 'binary') {
      yield new TemplateFile.fromBinary(path, decoded);
    } else {
      String source = UTF8.decode(decoded);
      yield new TemplateFile(path, source);
    }
  }
}

/**
 * Convert a directory name into a reasonably legal pub package name.
 */
String normalizeProjectName(String name) {
  name = name.replaceAll('-', '_').replaceAll(' ', '_');

  // Strip any extension (like .dart).
  if (name.contains('.')) {
    name = name.substring(0, name.indexOf('.'));
  }

  return name;
}

/**
 * Given a `String` [str] with mustache templates, and a [Map] of String key /
 * value pairs, substitute all instances of `__key__` for `value`. I.e.,
 *
 *     Foo __projectName__ baz.
 *
 * and
 *
 *     {'projectName': 'bar'}
 *
 * becomes:
 *
 *     Foo bar baz.
 *
 * A key value can only be an ASCII string made up of letters: A-Z, a-Z.
 * No whitespace, numbers, or other characters are allowed.
 */
String substituteVars(String str, Map<String, String> vars) {
  var nonValidKeys =
      vars.keys.where((k) => k.contains(_nonValidSubstitueRegExp)).toList();
  if (nonValidKeys.isNotEmpty) {
    throw new ArgumentError('vars.keys can only contain letters.');
  }

  return str.replaceAllMapped(_substitueRegExp, (match) {
    var item = vars[match[1]];

    if (item == null) {
      return match[0];
    } else {
      return item;
    }
  });
}

/**
 * Convert the given String into a String with newlines wrapped at an 80 column
 * boundary, with 2 leading spaces for each line.
 */
String convertToYamlMultiLine(String str) {
  return wrap(str, 78).map((line) => '  ${line}').join('\n');
}

/**
 * Break the given String into lines wrapped on a [col] boundary.
 */
Iterable<String> wrap(String str, [int col = 80]) sync* {
  while (str.length > col) {
    int index = col;

    while (index > 0 && str.codeUnitAt(index) != _RUNE_SPACE) {
      index--;
    }

    if (index == 0) {
      index = str.indexOf(' ');

      if (index == -1) {
        yield str;
        str = '';
      } else {
        yield str.substring(0, index).trim();
        str = str.substring(index).trim();
      }
    } else {
      yield str.substring(0, index).trim();
      str = str.substring(index).trim();
    }
  }

  if (str.length > 0) {
    yield str;
  }
}

/**
 * An abstract implementation of a [Generator].
 */
abstract class DefaultGenerator extends Generator {
  DefaultGenerator(String id, String label, String description,
      {List<String> categories: const []})
      : super(id, label, description, categories: categories);

  TemplateFile addFile(String path, String contents) =>
      addTemplateFile(new TemplateFile(path, contents));

  String getInstallInstructions() {
    if (getFile('pubspec.yaml') != null) {
      return "to provision required packages, run 'pub get'";
    } else {
      return '';
    }
  }
}
