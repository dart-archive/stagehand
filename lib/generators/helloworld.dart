// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library stagehand.helloworld;

import '../stagehand.dart';
import '../src/common.dart';
import 'helloworld_data.dart';

/**
 * A generator for a hello world command-line application.
 */
class HelloWorldGenerator extends DefaultGenerator {
  HelloWorldGenerator() : super(
      'helloworld',
      "A simple hello world command-line application.",
      categories: const ['dart', 'helloworld']) {

    for (TemplateFile file in decodeConcanenatedData(data)) {
      addTemplateFile(file);
    }

    setEntrypoint(getFile('bin/main.dart'));
  }
}
