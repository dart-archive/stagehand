// Copyright (c) 2015, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library stagehand.console.simple;

import '../stagehand.dart';
import '../src/common.dart';
import 'console_simple_data.dart';

/**
 * A generator for a hello world command-line application.
 */
class ConsoleSimpleGenerator extends DefaultGenerator {
  ConsoleSimpleGenerator()
      : super('console-simple', 'Console Application',
            'A simple command-line application.',
            categories: const ['dart', 'console']) {
    for (TemplateFile file in decodeConcatenatedData(data)) {
      addTemplateFile(file);
    }

    setEntrypoint(getFile('bin/main.dart'));
  }

  String getInstallInstructions() =>
      "run your app using 'dart ${entrypoint.path}'";
}
