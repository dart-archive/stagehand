// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/**
 * TODO:
 */
library stagehand.utils;

String gitIgnoreContents = '''
.DS_Store
packages
pubspec.lock
''';

/**
 * TODO:
 */
String substituteVars(String str, Map vars) {
  vars.forEach((key, value) {
    String sub = '{{${key}}}';
    str = str.replaceAll(sub, value);
  });
  return str;
}
