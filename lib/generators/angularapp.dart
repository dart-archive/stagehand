// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library stagehand.angularapp;

import '../stagehand.dart';
import '../src/common.dart';
import 'angularapp_data.dart';

/**
 * A generator for an Angular.dart application.
 */
class AngularAppGenerator extends DefaultGenerator {
  AngularAppGenerator() : super(
      'angularapp',
      "A starter template for an angular web app.",
      categories: const ['dart', 'web', 'angular']) {

    for (TemplateFile file in decodeConcanenatedData(data)) {
      addTemplateFile(file);
    }

    setEntrypoint(getFile('web/main.dart'));
  }

  String getInstallInstructions() => "${super.getInstallInstructions()}\n"
      "to run your app, use 'pub serve'";
}
