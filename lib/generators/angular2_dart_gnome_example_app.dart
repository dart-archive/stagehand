// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library stagehand.angular2gnome;

import '../stagehand.dart';
import '../src/common.dart';
import 'angular2_dart_gnome_example_app_data.dart';

/**
 * A generator for an Angular2 application.
 */
class Angular2DartGnomeExampleAppGenerator extends DefaultGenerator {
  Angular2DartGnomeExampleAppGenerator() : super('angular2-dart-gnome-example-app', 'Angular2 gnome example app',
          'A sample Angular2 application, with gnomes.',
          categories: const ['dart', 'web']) {
    for (TemplateFile file in decodeConcatenatedData(data)) {
      addTemplateFile(file);
    }

    setEntrypoint(getFile('web/index.html'));
  }

  String getInstallInstructions() => "${super.getInstallInstructions()}\n"
  "to run your app, use 'pub serve'";
}
