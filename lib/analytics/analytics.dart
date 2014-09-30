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
 * Your application should provide an opt-out option for the user. If they
 * opt-out, set the [disabled] field to `true`. This setting will persist
 * across sessions automatically. You can continue to call the `send*` methods;
 * the library itself will make sure that no data is sent when the [disabled]
 * flag is true;
 *
 * For an opt-in workflow, query the [enablementExplicitlyChanged] at startup.
 * This will be false if the [disabled] flag has never been set. Set the flag to
 * `true`, and prompt the user about GA opt-in. Once the [disabled] flag is set
 * (either way), the [enablementExplicitlyChanged] flag will always be true
 * (you won't have to re-prompt the user on each run of the application).
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
   * Whether analytics has been disabled by the user. Also, enable or disable
   * analytics.
   */
  bool disabled;

  /**
   * Whether the [disabled] value has been explicitly set (either enabled or
   * disabled).
   */
  bool get enablementExplicitlyChanged;

  Future sendScreenView(String viewName);
  Future sendEvent(String category, String action, [String label]);

  /**
   * In order to avoid sending any personally identifying information, the
   * [description] field must not contain the exception message. In addition,
   * only the first 100 chars of the description will be sent.
   */
  Future sendException(String description, [bool fatal]);
}

class AnalyticsMock extends Analytics {
  String get trackingId => 'UA-0';
  final bool logCalls;

  bool disabled = false;
  bool enablementExplicitlyChanged = false;

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
