// Copyright (c) 2015, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../stagehand.dart';
import '../src/common.dart';
import 'web_angular_quickstart_data.dart';

/**
 * The QuickStart example used in AngularDart docs.
 */
class WebAngularQuickstartGenerator extends DefaultGenerator {
  WebAngularQuickstartGenerator()
      : super('web-angular-quickstart', 'Angular QuickStart Example',
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
