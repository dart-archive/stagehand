// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library stagehand.analytics_impl_test;

import 'dart:async';

import 'package:stagehand/analytics/analytics.dart';
import 'package:stagehand/analytics/src/analytics_impl.dart';
import 'package:unittest/unittest.dart';

void main() => defineTests();

void defineTests() {
  group('ThrottlingBucket', () {
    test('can send', () {
      ThrottlingBucket bucket = new ThrottlingBucket(20);
      expect(bucket.removeDrop(), true);
    });

    test('doesn\'t send too many', () {
      ThrottlingBucket bucket = new ThrottlingBucket(20);
      for (int i = 0; i < 20; i++) {
        expect(bucket.removeDrop(), true);
      }
      expect(bucket.removeDrop(), false);
    });
  });

  group('sanitizeFilePaths', () {
    test('replace file', () {
      expect(sanitizeFilePaths(
          '(file:///Users/sethladd/tmp/error.dart:3:13)'),
          '(error.dart:3:13)');
    });

    test('replace files', () {
      expect(sanitizeFilePaths(
          'foo (file:///Users/sethladd/tmp/error.dart:3:13)\n'
          'bar (file:///Users/sethladd/tmp/error.dart:3:13)'),
          'foo (error.dart:3:13)\nbar (error.dart:3:13)');
    });
  });

  group('analytics_impl', () {
    test('simple', () {
      AnalyticsImplMock mock = new AnalyticsImplMock('UA-0');
      mock.sendScreenView('main');
      expect(mock.mockProperties['clientId'], isNotNull);
      expect(mock.mockPostHandler.sentValues, isNot(isEmpty));
    });

    test('respects disabled 1', () {
      AnalyticsImplMock mock = new AnalyticsImplMock('UA-0');
      mock.optIn = false;
      mock.sendException('FooBar exception');
      expect(mock.optIn, false);
      expect(mock.mockPostHandler.sentValues, isEmpty);
    });

//    test('respects disabled 2', () {
//      AnalyticsImplMock mock = new AnalyticsImplMock('UA-0');
//      mock.optIn = false;
//      mock.sendScreenView('fooBar');
//      expect(mock.optIn, false);
//      String viewName = mock.mockPostHandler.sentValues[0]['cd'];
//      expect(viewName, 'main');
//    });

    test('exception file paths', () {
      AnalyticsImplMock mock = new AnalyticsImplMock('UA-0');
      mock.sendException('foo bar (file:///Users/sethladd/tmp/error.dart:3:13)');
      String exd = mock.mockPostHandler.sentValues[0]['exd'];
      expect(exd, 'foo bar (');
    });
  });
}

class AnalyticsImplMock extends AnalyticsImpl {
  MockProperties get mockProperties => properties;
  MockPostHandler get mockPostHandler => postHandler;

  AnalyticsImplMock(String trackingId) :
    super(trackingId, new MockProperties(), new MockPostHandler()) {
    optIn = true;
  }
}

class MockProperties extends PersistentProperties {
  Map<String, dynamic> props = {};

  MockProperties() : super('mock');

  dynamic operator[](String key) => props[key];

  void operator[]=(String key, dynamic value) {
    props[key] = value;
  }
}

class MockPostHandler extends PostHandler {
  List<Map> sentValues = [];

  Future sendPost(String url, Map<String, String> parameters) {
    sentValues.add(parameters);

    return new Future.value();
  }
}
