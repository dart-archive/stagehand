// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// TODO: document how to support an opt-out workflow

// TODO: document how to support an opt-in workflow

/**
 * TODO:
 */
library stagehand.analytics;

import 'dart:async';

/**
 * TODO:
 */
abstract class Analytics {
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
   * TODO: document the GA restrictions here
   */
  Future sendException(String description, [bool fatal]);
}

class AnalyticsMock extends Analytics {
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
