// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library stagehand.ubersimplewebapp;

import '../stagehand.dart';
import '../src/common.dart';
import 'web_simple_data.dart';

/**
 * A generator for a uber-simple web application.
 */
class WebSimpleAppGenerator extends DefaultGenerator {
  WebSimpleAppGenerator() : super('web-simple',
          'Uber Simple Web Application', 'An absolute bare-bones web app.',
          categories: const ['dart', 'web']) {
    for (TemplateFile file in decodeConcatenatedData(data)) {
      addTemplateFile(file);
    }

    setEntrypoint(getFile('web/index.html'));
  }
}
