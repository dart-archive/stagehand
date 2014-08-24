
library stagehand.cli_test;

import 'dart:async';

import 'package:stagehand/stagehand.dart';
import 'package:unittest/unittest.dart';

import '../bin/stagehand.dart';

void main() => defineTests();

void defineTests() {
  group('cli', () {
    CliApp app;
    CliControllerMock controller;
    GeneratorTargetMock target;
    
    setUp(() {
      controller = new CliControllerMock();
      target = new GeneratorTargetMock();
      app = new CliApp(generators, controller, target);
    });
    
    void _expectOk([_]) {
      expect(controller.getError(), isEmpty);
      expect(controller.getStdout(), isNot(isEmpty));
    }

    Future _expectError(Future f, [bool hasStdout = true]) {
      return f
        .then((_) => fail('error expected'))
        .catchError((e) {
          expect(controller.getError(), isNot(isEmpty));
          if (hasStdout) {
            expect(controller.getStdout(), isNot(isEmpty));
          } else {
            expect(controller.getStdout(), isEmpty);
          }
        });
    }
    
    test('no args', () {
      return app.process([]).then(_expectOk);
    });

    test('one arg', () {
      return app.process(['helloworld']).then(_expectOk);
    });
    
    test('one arg (bad)', () {
      return _expectError(app.process(['bad_generator']));
    });
    
    test('two args', () {
      return app.process(['helloworld', 'foobar']).then((_) {
        _expectOk();
        expect(target.createdCount, isPositive);
      });
    });
    
    test('two args (directory exists)', () {
      return _expectError(app.process(['helloworld', 'packages']), false);
    });
    
    test('three args', () {
      return _expectError(app.process(['helloworld', 'foobar', 'baz']));
    });
  });
}

class CliControllerMock implements CliController {
  StringBuffer _error = new StringBuffer();
  StringBuffer _stdout = new StringBuffer();

  void error(String message) => _error.write(message);
  void stdout(String message) => _stdout.write(message);

  String getError() => _error.toString();
  String getStdout() => _stdout.toString();
}

class GeneratorTargetMock implements GeneratorTarget {
  int createdCount = 0;
  
  Future createFile(String path, List<int> contents) {
    expect(contents, isNot(isEmpty));
    expect(path, isNot(startsWith('/')));
    
    createdCount++;
    
    return new Future.value();
  }
}
