// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:stagehand/src/common.dart';
import 'package:test/test.dart';

void main() {
  group('common', () {
    test('normalizeProjectName', () {
      expect(normalizeProjectName('foo.dart'), 'foo');
      expect(normalizeProjectName('foo-bar'), 'foo_bar');
    });

    group('substituteVars', () {
      test('simple', () {
        _expect('foo __bar__ baz', {'bar': 'baz'}, 'foo baz baz');
      });

      test('nosub', () {
        _expect('foo __bar__ baz', {'aaa': 'bbb'}, 'foo __bar__ baz');
      });

      test('matching input', () {
        _expect('foo __bar__ baz', {'bar': '__baz__', 'baz': 'foo'},
            'foo __baz__ baz');
      });

      test('vars must be alpha + numeric', () {
        expect(() => substituteVars('str', {'with space': 'noop'}),
            throwsArgumentError);
        expect(() => substituteVars('str', {'with!symbols': 'noop'}),
            throwsArgumentError);
        expect(() => substituteVars('str', {'with1numbers': 'noop'}),
            throwsArgumentError);
        expect(() => substituteVars('str', {'with_under': 'noop'}),
            throwsArgumentError);
      });
    });

    test('wrap', () {
      expect(wrap('foo barbar baz'), ['foo barbar baz']);
      expect(wrap('foo barbar baz', 10), ['foo barbar', 'baz']);
    });

    test('convertToYamlMultiLine', () {
      expect(
          convertToYamlMultiLine(
              'one two three four five size seven eight nine '
              'ten eleven twelve thirteen fourteen fifteen'),
          '  one two three four five size seven eight nine ten eleven twelve '
          'thirteen\n  fourteen fifteen');
    });
  });
}

void _expect(String original, Map<String, String> vars, String result) {
  expect(substituteVars(original, vars), result);
}
