// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../common.dart';

part 'console_full.g.dart';

/// A generator for a hello world command-line application.
class ConsoleFullGenerator extends DefaultGenerator {
  ConsoleFullGenerator()
      : super('console-full', 'Console Application',
            'A command-line application sample.',
            categories: const ['dart', 'console']) {
    for (var file in decodeConcatenatedData(_data)) {
      addTemplateFile(file);
    }

    setEntrypoint(getFile('bin/__projectName__.dart'));
  }

  @override
  String getInstallInstructions() => '${super.getInstallInstructions()}\n'
      'run your app using `dart ${entrypoint.path}`.';
}
