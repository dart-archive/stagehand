// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/**
 * `analytics` is a wrapper around Google Analytics for both command-line apps
 * and web apps.
 *
 * In order to use this library as a web app, import the `analytics_html.dart`
 * library and instantiate the [AnalyticsHtml] class.
 *
 * In order to use this library as a command-line app, import the
 * `analytics_io.dart` library and instantiate the [AnalyticsIO] class.
 *
 * For both classes, you need to provide a Google Analytics tracking ID, the
 * application name, and the application version.
 *
 * Your application should provide an opt-in option for the user. If they
 * opt-in, set the [optIn] field to `true`. This setting will persist across
 * sessions automatically.
 *
 * For more information, please see the Google Analytics Measurement Protocol
 * [Policy](https://developers.google.com/analytics/devguides/collection/protocol/policy).
 */
library stagehand.analytics;

import 'dart:async';

/**
 * An interface to a Google Analytics session. [AnalyticsHtml] and [AnalyticsIO]
 * are concrete implementations of this interface. [AnalyticsMock] can be used
 * for testing or for some varients of an opt-in workflow.
 */
abstract class Analytics {
  /**
   * Tracking ID / Property ID.
   */
  String get trackingId;

  /**
   * Whether the user has opt-ed in to additional analytics.
   */
  bool optIn;

  /**
   * Whether the [optIn] value has been explicitly set (either `true` or
   * `false`).
   */
  bool get hasSetOptIn;

  Future sendScreenView(String viewName);

  Future sendEvent(String category, String action, [String label]);

  /**
   * In order to avoid sending any personally identifying information, the
   * [description] field must not contain the exception message. In addition,
   * only the first 100 chars of the description will be sent.
   */
  Future sendException(String description, [bool fatal]);
}

// Matches file:/, non-ws, /, non-ws, .dart
final RegExp _pathRegex = new RegExp(r'file:/\S+/(\S+\.dart)');

/**
 * Santitize a string potentially containing file paths. This will remove all
 * but the last file name in order to remove any PII that may be contained in
 * the full file path. For example, this will shorten:
 *
 *     file:///Users/sethladd/tmp/error.dart
 *
 * to
 *
 *     error.dart
 */
String sanitizeFilePaths(String stackTrace) {
  Iterable<Match> iter = _pathRegex.allMatches(stackTrace);
  iter = iter.toList().reversed;

  for (Match match in iter) {
    String replacement = match.group(1);
    stackTrace = stackTrace.substring(0, match.start)
        + replacement + stackTrace.substring(match.end);
  }

  return stackTrace;
}

class AnalyticsMock extends Analytics {
  String get trackingId => 'UA-0';
  final bool logCalls;

  bool optIn = false;
  bool hasSetOptIn = true;

  AnalyticsMock([this.logCalls = false]);

  Future sendScreenView(String viewName) {
    return _log('screenView', {'viewName': viewName});
  }

  Future sendEvent(String category, String action, [String label]) {
    return _log('event', {'category': category, 'action': action, 'label': label});
  }

  Future sendException(String description, [bool fatal]) {
    return _log('exception', {'description': description, 'fatal': fatal});
  }

  Future _log(String hitType, Map m) {
    if (logCalls) {
      print('analytics: ${hitType} ${m}');
    }

    return new Future.value();
  }
}
