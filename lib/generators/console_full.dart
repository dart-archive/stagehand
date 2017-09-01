// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../src/common.dart';
import '../stagehand.dart';
import 'console_full_data.dart';

/**
 * A generator for a hello world command-line application.
 */
class ConsoleFullGenerator extends DefaultGenerator {
  ConsoleFullGenerator()
      : super('console-full', 'Console Application',
            'A command-line application sample.',
            categories: const ['dart', 'console']) {
    for (TemplateFile file in decodeConcatenatedData(data)) {
      addTemplateFile(file);
    }

    setEntrypoint(getFile('bin/main.dart'));
  }

  String getInstallInstructions() => "${super.getInstallInstructions()}\n"
      "run your app using 'dart ${entrypoint.path}'";
}
