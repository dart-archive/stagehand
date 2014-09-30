// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library stagehand.webapp;

import '../stagehand.dart';
import '../src/common.dart';
import 'webapp_data.dart';

/**
 * A generator for a minimal web application.
 */
class WebAppGenerator extends DefaultGenerator {
  WebAppGenerator() : super(
      'webapp',
      "A minimal web app for the developer that doesn’t want to be confused by "
      "too much going on.",
      categories: const ['dart', 'web', 'minimal']) {

    for (TemplateFile file in decodeConcanenatedData(data)) {
      addTemplateFile(file);
    }

    setEntrypoint(getFile('web/index.html'));
  }
}
