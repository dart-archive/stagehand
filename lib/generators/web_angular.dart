// Copyright (c) 2015, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library stagehand.web.angular;

import '../stagehand.dart';
import '../src/common.dart';
import 'web_angular_data.dart';

/**
 * A generator for an Angular 2 application.
 */
class WebAngularGenerator extends DefaultGenerator {
  WebAngularGenerator()
      : super('web-angular', 'Angular 2 Web Application',
            'A web app built using Angular 2.',
            categories: const ['dart', 'web']) {
    for (TemplateFile file in decodeConcatenatedData(data)) {
      addTemplateFile(file);
    }

    setEntrypoint(getFile('web/index.html'));
  }

  String getInstallInstructions() => "${super.getInstallInstructions()}\n"
      "to run your app, use 'pub serve'";
}
