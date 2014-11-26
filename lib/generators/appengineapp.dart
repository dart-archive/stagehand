// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library stagehand.appengineapp;

import 'appengineapp_data.dart';
import '../stagehand.dart';
import '../src/common.dart';

/**
 * A generator for a hello world AppEngine application.
 */
class AppEngineAppGenerator extends DefaultGenerator {
  AppEngineAppGenerator() : super(
      'appengineapp',
      'AppEngine Application',
      'A simple AppEngine application.',
      categories: const ['dart', 'appengine', 'server']) {

    for (TemplateFile file in decodeConcanenatedData(data)) {
      addTemplateFile(file);
    }

    setEntrypoint(getFile('bin/server.dart'));
  }

  String getInstallInstructions() =>
      "${super.getInstallInstructions()}\n"
      "run your app using 'gcloud preview app run app.yaml'";
}
