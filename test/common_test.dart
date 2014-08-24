
library stagehand.common_test;

import 'package:stagehand/src/common.dart';
import 'package:unittest/unittest.dart';

void main() => defineTests();

void defineTests() {
  group('common', () {
    test('gitIgnoreContents', () {
      expect(gitIgnoreContents, isNot(isEmpty));
    });
    
    test('substituteVars simple', () {
      _expect('foo {{bar}} baz', {'bar': 'baz'}, 'foo baz baz');
    });
    
    test('substituteVars nosub', () {
      _expect('foo {{bar}} baz', {'aaa': 'bbb'}, 'foo {{bar}} baz');
    });
  });
}

void _expect(String original, Map vars, String result) {
  expect(substituteVars(original, vars), result);
}
