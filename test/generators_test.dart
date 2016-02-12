// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:stagehand/stagehand.dart';
import 'package:test/test.dart';

void main() {
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
  expect(generator.getInstallInstructions(), isNotNull);
}
