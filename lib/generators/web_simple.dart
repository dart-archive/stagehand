// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../src/common.dart';
import '../stagehand.dart';
import 'web_simple_data.dart';

/**
 * A generator for a uber-simple web application.
 */
class WebSimpleGenerator extends DefaultGenerator {
  WebSimpleGenerator()
      : super('web-simple', 'Bare-bones Web App',
            'A web app that uses only core Dart libraries.',
            categories: const ['dart', 'web']) {
    for (TemplateFile file in decodeConcatenatedData(data)) {
      addTemplateFile(file);
    }

    setEntrypoint(getFile('web/index.html'));
  }
}
