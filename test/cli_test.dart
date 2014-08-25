//  Copyright (c) 2014, Seth Ladd.
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//  * Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in the
//  documentation and/or other materials provided with the distribution.
//  * Neither the name of the <organization> nor the
//  names of its contributors may be used to endorse or promote products
//  derived from this software without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
//  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

library stagehand.cli_test;

import 'dart:async';

import 'package:stagehand/stagehand.dart';
import 'package:unittest/unittest.dart';

import '../bin/stagehand.dart';

void main() => defineTests();

void defineTests() {
  group('cli', () {
    CliApp app;
    CliLoggerMock logger;
    GeneratorTargetMock target;
    
    setUp(() {
      logger = new CliLoggerMock();
      target = new GeneratorTargetMock();
      app = new CliApp(generators, logger, target);
    });
    
    void _expectOk([_]) {
      expect(logger.getStderr(), isEmpty);
      expect(logger.getStdout(), isNot(isEmpty));
    }

    Future _expectError(Future f, [bool hasStdout = true]) {
      return f
        .then((_) => fail('error expected'))
        .catchError((e) {
          expect(logger.getStderr(), isNot(isEmpty));
          if (hasStdout) {
            expect(logger.getStdout(), isNot(isEmpty));
          } else {
            expect(logger.getStdout(), isEmpty);
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

class CliLoggerMock implements CliLogger {
  StringBuffer _stdout = new StringBuffer();
  StringBuffer _stderr = new StringBuffer();

  void stderr(String message) => _stderr.write(message);
  void stdout(String message) => _stdout.write(message);

  String getStdout() => _stdout.toString();
  String getStderr() => _stderr.toString();
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
