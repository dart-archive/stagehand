// Copyright (c) __year__, __author__. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';

@Component(
    selector: 'my-app',
    styleUrls: const ['app_component.css'],
    templateUrl: 'app_component.html',
    directives: const [materialDirectives],
    providers: const [materialProviders])
class AppComponent {
  /// Visibility state of the 'hello world' dialog.
  bool helloVisible = false;

  /// Name of user.
  String name = "";
}
