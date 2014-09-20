// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library stagehand.webstarterkit;

import '../stagehand.dart';
import '../src/common.dart';
import 'webstarterkit_data.dart';

/**
 * A generator for a hello world command-line application.
 */
class WebStarterKitGenerator extends DefaultGenerator {
  WebStarterKitGenerator() : super(
      'webstarterkit',
      "An awesome mobile web experience.",
      categories: const ['dart', 'webstarterkit']) {

    for (TemplateFile file in decodeConcanenatedData(data)) {
      addTemplateFile(file);
    }

    setEntrypoint(getFile('web/index.html'));
  }
}
