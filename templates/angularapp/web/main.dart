// Copyright (c) {{year}}, {{author}}. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';

import 'package:{{projectName}}/main_app.dart';

class MyAppModule extends Module {

  MyAppModule() {
    bind(MainApp);
  }
}

void main() {
  applicationFactory()
  .addModule(new MyAppModule())
  .run();
}