// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// @dart=2.9

@TestOn('vm')
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:stagehand/src/cli_app.dart';
import 'package:stagehand/stagehand.dart';
import 'package:test/test.dart';
import 'package:usage/usage.dart';

void main() {
  group('cli', () {
    CliApp app;
    CliLoggerMock logger;
    GeneratorTargetMock target;

    setUp(() {
      logger = CliLoggerMock();
      target = GeneratorTargetMock();
      app = CliApp(generators, logger, target)
        ..cwd = Directory('test')
        ..analytics = AnalyticsMock();
    });

    void _expectOk() {
      expect(logger.getStderr(), isEmpty);
      expect(logger.getStdout(), isNot(isEmpty));
    }

    Future<void> _expectError(Future f, [bool hasStdout = true]) async {
      try {
        await f;
        fail('error expected');
      } catch (e) {
        expect(logger.getStderr(), isNot(isEmpty));
        if (hasStdout) {
          expect(logger.getStdout(), isNot(isEmpty));
        } else {
          expect(logger.getStdout(), isEmpty);
        }
      }
    }

    test('no args', () async {
      await app.process([]);
      _expectOk();
    });

    test('one arg', () async {
      await app.process(['console-full']);
      _expectOk();
      expect(target.createdCount, isPositive);
    });

    test('one arg (bad)', () async {
      await _expectError(app.process(['bad_generator']));
    });

    test('two args', () async {
      await _expectError(app.process(['consoleapp', 'foobar']));
    });

    group('machine format', () {
      test('returns a list of results', () async {
        await app.process(['--machine']);
        _expectOk();
        final List results = jsonDecode(logger.getStdout());
        expect(results, isNotEmpty);
      });

      test('includes categories', () async {
        await app.process(['--machine']);
        _expectOk();
        final List results = jsonDecode(logger.getStdout());

        final consoleFull =
            results.singleWhere((item) => item['name'] == 'console-full');
        expect(consoleFull, isNotNull);
        expect(
          consoleFull['categories'],
          allOf(isNotNull, isList, contains('dart'), contains('console')),
        );
      });
    });

    test('version', () async {
      await app.process(['--version']);
      _expectOk();
      expect(logger.getStdout(), contains('stagehand version'));
    });
  });
}

class CliLoggerMock implements CliLogger {
  final StringBuffer _stdout = StringBuffer();
  final StringBuffer _stderr = StringBuffer();

  @override
  void stderr(String message) => _stderr.write(message);

  @override
  void stdout(String message) => _stdout.write(message);

  String getStdout() => _stdout.toString();

  String getStderr() => _stderr.toString();
}

class GeneratorTargetMock implements GeneratorTarget {
  int createdCount = 0;

  @override
  Future createFile(String path, List<int> contents) {
    expect(contents, isNot(isEmpty));
    expect(path, isNot(startsWith('/')));

    createdCount++;

    return Future.value();
  }
}
