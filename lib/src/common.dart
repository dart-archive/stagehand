// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/**
 * Some utilty methods for stagehand.
 */
library stagehand.utils;

/**
 * A common `.gitignore` file for Dart projects.
 */
String gitIgnoreContents = '''
.DS_Store
build/
packages
pubspec.lock
''';

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
