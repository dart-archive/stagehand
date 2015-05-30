// Copyright (c) {{year}}, {{author}}. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';
import 'package:angular2/src/reflection/reflection.dart' show reflector;
import 'package:angular2/src/reflection/reflection_capabilities.dart' show ReflectionCapabilities;
import 'package:gnome_tutorial/gnome_app.dart';

void main() {
  // this won't be needed in a later version of Angular
  reflector.reflectionCapabilities = new ReflectionCapabilities();

  // boostrap Angular
  bootstrap(GnomeApp);
}