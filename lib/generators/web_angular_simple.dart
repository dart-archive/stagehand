// Copyright (c) 2016, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../stagehand.dart';
import '../src/common.dart';
import 'web_angular_simple_data.dart';

/**
 * The simple starter example used in AngularDart docs.
 */
class WebAngularSimpleGenerator extends DefaultGenerator {
  WebAngularSimpleGenerator()
      : super('web-angular-simple', 'Simple Angular Example',
            'A minimalist example app used in docs.',
            categories: const ['dart', 'web']) {
    for (TemplateFile file in decodeConcatenatedData(data)) {
      addTemplateFile(file);
    }

    setEntrypoint(getFile('web/index.html'));
  }

  String getInstallInstructions() => "${super.getInstallInstructions()}\n"
      "to run your app, use 'pub serve'";
}
