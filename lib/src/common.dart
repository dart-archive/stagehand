// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/**
 * Some utilty methods for stagehand.
 */
library stagehand.utils;

import 'dart:convert' show UTF8;

import 'package:crypto/crypto.dart';

import '../stagehand.dart';

const int _RUNE_SPACE = 32;

/**
 * A common `.gitignore` file for Dart projects.
 */
const String gitIgnoreContents = '''
.DS_Store
build/
packages
pubspec.lock
.idea
''';

/**
 * The BSD 3-clause license.
 */
String get licenseContents => '''
Copyright (c) ${new DateTime.now().year}, <your name>.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the <organization> nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
''';

List<TemplateFile> decodeConcanenatedData(List<String> data) {
  List<TemplateFile> results = [];

  for (int i = 0; i < data.length; i += 3) {
    String path = data[i];
    String type = data[i + 1];
    String raw = data[i + 2];

    List<int> decoded = CryptoUtils.base64StringToBytes(raw);

    if (type == 'binary') {
      results.add(new TemplateFile.fromBinary(path, decoded));
    } else {
      String source = UTF8.decode(decoded);
      results.add(new TemplateFile(path, source));
    }
  }

  return results;
}

/**
 * Convert a directory name into a reasonably legal pub package name.
 */
String normalizeProjectName(String name) {
  name = name.replaceAll('-', '_');

  // Strip any extension (like .dart).
  if (name.contains('.')) {
    name = name.substring(0, name.indexOf('.'));
  }

  return name;
}

/**
 * Given a String [str] with mustache templates, and a [Map] of String key /
 * value pairs, substitute all instances of `{{key}}` for `value`. I.e.,
 *
 *     Foo {{projectName}} baz.
 *
 * and
 *
 *     {'projectName': 'bar'}
 *
 * becomes:
 *
 *     Foo bar baz.
 */
String substituteVars(String str, Map<String, String> vars) {
  vars.forEach((key, value) {
    String sub = '{{${key}}}';
    str = str.replaceAll(sub, value);
  });
  return str;
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
List<String> wrap(String str, [int col = 80]) {
  List<String> lines = [];

  while (str.length > col) {
    int index = col;

    while (index > 0 && str.codeUnitAt(index) != _RUNE_SPACE) {
      index--;
    }

    if (index == 0) {
      index = str.indexOf(' ');

      if (index == -1) {
        lines.add(str);
        str = '';
      } else {
        lines.add(str.substring(0, index).trim());
        str = str.substring(index).trim();
      }
    } else {
      lines.add(str.substring(0, index).trim());
      str = str.substring(index).trim();
    }
  }

  if (str.length > 0) {
    lines.add(str);
  }

  return lines;
}

/**
 * An abstract implementation of a [Generator] that includes default
 * `.gitignore` and `LICENSE` files.
 */
abstract class DefaultGenerator extends Generator {
  DefaultGenerator(String id, String description, {List<String> categories: const []})
      : super(id, description, categories: categories) {
    addFile('.gitignore', gitIgnoreContents);
    addFile('LICENSE', licenseContents);
  }

  TemplateFile addFile(String path, String contents) =>
      addTemplateFile(new TemplateFile(path, contents));
}
