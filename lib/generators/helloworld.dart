// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library stagehand.helloworld;

import '../src/common.dart';

/**
 * A generator for a hello world command-line application.
 */
class HelloWorldGenerator extends DefaultGenerator {
  HelloWorldGenerator() : super(
      'helloworld',
      "A simple hello world command-line application.",
      categories: const ['dart', 'helloworld']) {

    addFile('pubspec.yaml', _pubspec);
    addFile('readme.md', _readme);
    setEntrypoint(addFile('bin/main.dart', _helloworld));
  }

  String get _pubspec => '''
name: {{projectName}}
version: 0.0.1
description: ${description}
#author: First Last <email@example.com>
#homepage: https://www.example.com
environment:
  sdk: '>=1.0.0 <2.0.0'
#dependencies:
#  foo_bar: any
''';

  String get _readme => '''
# {{projectName}}

A simple hello world command-line application.
''';

  String get _helloworld => '''
main() {
  print('Hello world!');
}
''';
}
