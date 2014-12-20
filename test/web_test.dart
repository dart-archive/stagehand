// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library stagehand.web_test;

import 'dart:async';

import 'package:stagehand/stagehand.dart';
import 'package:unittest/html_config.dart';
import 'package:unittest/unittest.dart';

import 'common_test.dart' as common_test;
import 'generators_test.dart' as generators_test;

// TODO: get the tests running in content_shell

void main() {
  // Set up the test environment.
  useHtmlConfiguration();

  // Define the tests.
  common_test.defineTests();
  generators_test.defineTests();
  defineIntegrationTests();
}

void defineIntegrationTests() {
  group('integration', () {
    generators.forEach((generator) {
      test(generator.id, () => testGenerator(getGenerator(generator.id)));
    });
  });
}

Future testGenerator(Generator generator) {
  expect(generator.id, isNotNull);

  MockTarget target = new MockTarget();

  // Assert that we can generate the template.
  return generator.generate('foo', target).then((_) {
    // Run some basic validation on the generated results.
    expect(target.getFileContentsAsString('.gitignore'), isNotNull);
    expect(target.getFileContentsAsString('pubspec.yaml'), isNotNull);
  });
}

class MockTarget extends GeneratorTarget {
  Map<String, List<int>> files = {};

  Future createFile(String path, List<int> contents) {
    files[path] = contents;
    return new Future.value();
  }

  bool hasFile(String path) => files.containsKey(path);

  String getFileContentsAsString(String path) {
    if (!hasFile(path)) return null;
    return new String.fromCharCodes(files[path]);
  }
}
