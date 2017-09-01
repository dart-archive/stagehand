// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../src/common.dart';
import '../stagehand.dart';
import 'package_simple_data.dart';

/**
 * A generator for a pub library.
 */
class PackageSimpleGenerator extends DefaultGenerator {
  PackageSimpleGenerator()
      : super('package-simple', 'Dart Package',
            'A starting point for Dart libraries or applications.',
            categories: const ['dart']) {
    for (TemplateFile file in decodeConcatenatedData(data)) {
      addTemplateFile(file);
    }

    setEntrypoint(getFile('lib/__projectName__.dart'));
  }
}
