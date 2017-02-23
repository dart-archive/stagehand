// Copyright (c) __year__, __author__. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';

@Component(
  selector: 'my-app',
  template: '<h1>Hello {{name}}</h1>'
)
class AppComponent {
  var name = 'Angular';
}
