// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// TODO: document how to support an opt-out workflow

// TODO: document how to support an opt-in workflow

/**
 * TODO:
 */
library stagehand.analytics;

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

  void sendScreenView(String viewName);
  void sendEvent(String category, String action, [String label]);
  void sendException(String description, [bool fatal]);
}

class AnalyticsMock extends Analytics {
  final bool logCalls;

  bool disabled = false;
  bool enablementExplicitlyChanged = false;

  AnalyticsMock([this.logCalls = false]);

  void sendScreenView(String viewName) {
    if (logCalls) _log('screenView', viewName);
  }

  void sendEvent(String category, String action, [String label]) {
    if (logCalls) {
      if (label == null) {
        _log('event', '${action}');
      } else {
        _log('event', '${action},${label}');
      }
    }
  }

  void sendException(String description, [bool fatal]) {
    if (logCalls) {
      if (fatal == null) {
        _log('event', '${description}');
      } else {
        _log('event', '${description},fatal=${fatal}');
      }
    }
  }

  void _log(String hitType, String message) {
    print('analytics: ${hitType} ${message}');
  }
}
