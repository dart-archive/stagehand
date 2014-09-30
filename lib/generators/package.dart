// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library stagehand.package;

import '../stagehand.dart';
import '../src/common.dart';
import 'package_data.dart';

/**
 * A generator for a pub library.
 */
class PackageGenerator extends DefaultGenerator {
  PackageGenerator() : super(
      'package',
      "A library useful for applications or for sharing on pub.dartlang.org.",
      categories: const ['dart']) {

    for (TemplateFile file in decodeConcanenatedData(data)) {
      addTemplateFile(file);
    }

    setEntrypoint(getFile('lib/projectName.dart'));
  }
}
