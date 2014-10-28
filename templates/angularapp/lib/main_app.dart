// Copyright (c) {{year}}, {{author}}. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular/angular.dart';

/// A angular `<main-app>` element.
@Component(
  selector : 'main-app',
  templateUrl : 'packages/{{projectName}}/main_app.html',
  cssUrl : 'packages/{{projectName}}/main_app.css'
)
class MainApp {
  String input = '';

  String get reversed => input.split('').reversed.join('');
}