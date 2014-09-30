// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library stagehand.webapp;

import '../stagehand.dart';
import '../src/common.dart';
import 'polymer_data.dart';

/**
 * A generator for a polymer.dart application.
 */
class PolymerGenerator extends DefaultGenerator {
  PolymerGenerator() : super(
      'polymer',
      "A polymer.dart web app.",
      categories: const ['dart', 'web']) {

    for (TemplateFile file in decodeConcanenatedData(data)) {
      addTemplateFile(file);
    }

    setEntrypoint(getFile('web/index.html'));
  }
}
