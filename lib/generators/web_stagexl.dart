// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../stagehand.dart';
import '../src/common.dart';
import 'web_stagexl_data.dart';

/**
 * A generator for a StageXL web application.
 */
class WebStageXlGenerator extends DefaultGenerator {
  WebStageXlGenerator()
      : super('web-stagexl', 'Simple StageXL Application',
            'A basic 2D canvas app with StageXL.',
            categories: const ['dart', 'web']) {
    for (TemplateFile file in decodeConcatenatedData(data)) {
      addTemplateFile(file);
    }

    setEntrypoint(getFile('web/index.html'));
  }
}
