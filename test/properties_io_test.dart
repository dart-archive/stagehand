// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library stagehand.properties_io_test;

import 'package:stagehand/properties/properties_io.dart';
import 'package:unittest/unittest.dart';

void main() => defineTests();

void defineTests() {
  group('properties_io', () {
    test('create', () {
      PropertiesIO.create('test_foo');
    });

    test('set get', () {
      Properties props = PropertiesIO.create('test_foo');
      props['foo'] = 'bar';
      expect(props['foo'], 'bar');
    });

    test('dirty', () {
      Properties props = PropertiesIO.create('test_foo');
      expect(props.dirty, false);
      props['foo'] = 'bar';
      expect(props.dirty, true);
    });
  });
}
