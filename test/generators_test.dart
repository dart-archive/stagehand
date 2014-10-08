// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library stagehand.generators_test;

import 'package:stagehand/stagehand.dart';
import 'package:unittest/unittest.dart';

void main() => defineTests();

void defineTests() {
  group('generators', () {
    generators.forEach((generator) {
      test(generator.id, () => validate(getGenerator(generator.id)));
    });
  });
}

void validate(Generator generator) {
  expect(generator.id, isNot(contains(' ')));
  expect(generator.description, endsWith('.'));
  expect(generator.entrypoint, isNotNull);
}
