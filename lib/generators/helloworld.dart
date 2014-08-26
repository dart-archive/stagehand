// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library stagehand.helloworld;

import '../src/common.dart';
import '../stagehand.dart';

/**
 * TODO:
 */
class HelloWorldGenerator extends Generator {
  HelloWorldGenerator() : super(
      'helloworld',
      "A simple hello world command-line application.",
      categories: const ['dart', 'helloworld']) {

    _addFile('.gitignore', gitIgnoreContents);
    _addFile('pubspec.yaml', _pubspec);
    _addFile('bin/helloworld.dart', _helloworld);

    setEntrypoint(files.last);
  }

  String get _pubspec => '''
name: {{projectName}}
version: 0.0.1
description: ${description}
''';

  String get _helloworld => '''
main() {
  print('Hello world!');
}
''';

  TemplateFile _addFile(String path, String contents) =>
      addFile(new TemplateFile(path, contents));
}
