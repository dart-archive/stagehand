// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library stagehand.consoleapp;

import '../stagehand.dart';
import '../src/common.dart';
import 'consoleapp_data.dart';

/**
 * A generator for a hello world command-line application.
 */
class ConsoleAppGenerator extends DefaultGenerator {
  ConsoleAppGenerator() : super(
      'consoleapp',
      'Console Application',
      'A simple command-line application.',
      categories: const ['dart', 'console', 'minimal']) {

    for (TemplateFile file in decodeConcatenatedData(data)) {
      addTemplateFile(file);
    }

    setEntrypoint(getFile('bin/main.dart'));
  }

  String getInstallInstructions() =>
      "${super.getInstallInstructions()}\n"
      "run your app using 'dart ${entrypoint.path}'";
}
