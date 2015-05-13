// Copyright (c) {{year}}, {{author}}. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library {{projectName}}.test;

import 'package:test/test.dart';

import 'package:{{projectName}}/{{projectName}}.dart';

void main() {
  test('calculate', () {
    expect(calculate(), 42);
  });
}
