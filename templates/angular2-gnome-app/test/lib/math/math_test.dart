// Copyright (c) {{year}}, {{author}}. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:gnome_tutorial/math/math.dart';

main() {
  // test that doesn't require a browser
  group('vm test', () {
    test('math', () {
      expect(Math.doubleIt(2), equals(4));
    });
  });
}