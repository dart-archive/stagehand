
library stagehand.generators_test;

import 'package:stagehand/stagehand.dart';
import 'package:unittest/unittest.dart';

void main() => defineTests();

void defineTests() {
  group('generators', () {
    test('helloworld', () => validate(getGenerator('helloworld')));
    test('webapp', () => validate(getGenerator('webapp')));
  });
}

void validate(Generator generator) {
  expect(generator.id, isNot(contains(' ')));
  expect(generator.description, endsWith('.'));
  expect(generator.entrypoint, isNotNull);
}
