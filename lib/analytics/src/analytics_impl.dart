// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library stagehand.analytics_impl;

import 'dart:async';
import 'dart:math' as math;

import 'package:uuid/uuid.dart';

import '../analytics.dart';

// https://developers.google.com/analytics/devguides/collection/protocol/policy

String postEncode(Map<String, String> map) {
  // &foo=bar
  return map.keys
      .map((key) => "${key}=${Uri.encodeComponent(map[key])}")
      .join('&');
}

/**
 * A throttling algorithim. This models the throttling after a bucket with
 * water dripping into it at the rate of 1 drop per second. If the bucket has
 * water when an operation is requested, 1 drop of water is removed and the
 * operation is performed. If not the operation is skipped. This algorithim
 * lets operations be peformed in bursts without throttling, but holds the
 * overall average rate of operations to 1 per second.
 */
class ThrottlingBucket {
  final int startingCount;
  int drops;
  int _lastReplenish;

  ThrottlingBucket(this.startingCount) {
    drops = startingCount;
    _lastReplenish = new DateTime.now().millisecondsSinceEpoch;
  }

  bool removeDrop() {
    _checkReplenish();

    if (drops <= 0) {
      return false;
    } {
      drops--;
      return true;
    }
  }

  void _checkReplenish() {
    int now = new DateTime.now().millisecondsSinceEpoch;

    if (_lastReplenish + 1000 >= now) {
      int inc = (now - _lastReplenish) ~/ 1000;
      drops = math.min(drops + inc, startingCount);
      _lastReplenish += (1000 * inc);
    }
  }
}

abstract class AnalyticsImpl implements Analytics {
  static const String _GA_URL = 'https://www.google-analytics.com/collect';

  /// Tracking ID / Property ID.
  final String trackingId;
  final String applicationName;
  final String applicationVersion;

  final PersistentProperties properties;
  final PostHandler postHandler;

  final ThrottlingBucket _bucket = new ThrottlingBucket(20);

  AnalyticsImpl(this.trackingId, this.properties, this.postHandler,
      {this.applicationName, this.applicationVersion}) {
    assert(trackingId != null);
    _initClientId();
  }

  /**
   * Anonymous Client ID. The value of this field should be a random UUID v4.
   */
  String get _clientId => properties['clientId'];

  bool get disabled => properties['disabled'] == true;

  set disabled(bool value) {
    properties['disabled'] = value;
  }

  void sendScreenView(String viewName) {
    Map args = {'cd': viewName};
    return _sendPayload('screenview', args);
  }

  void sendEvent(String category, String action, [String label]) {
    Map args = {'ec': category, 'ea': action};
    if (label != null) args['el'] = label;
    return _sendPayload('event', args);
  }

  void sendException(String description, [bool fatal]) {
    Map args = {'exd': description};
    if (fatal != null && fatal) args['exf'] = '1';
    return _sendPayload('exception', args);
  }

  void _initClientId() {
    if (_clientId == null) {
      properties['clientId'] = new Uuid().v4();
    }
  }

  // Valid values for [hitType] are: 'pageview', 'screenview', 'event',
  // 'transaction', 'item', 'social', 'exception', and 'timing'.
  void _sendPayload(String hitType, Map args) {
    if (_bucket.removeDrop()) {
      args['v'] = '1'; // version
      args['tid'] = trackingId;
      args['cid'] = _clientId;
      args['t'] = hitType;

      if (applicationName != null) args['an'] = applicationName;
      if (applicationVersion != null) args['av'] = applicationVersion;

      postHandler.sendPost(_GA_URL, args);
    }
  }
}

abstract class PersistentProperties {
  final String name;

  PersistentProperties(this.name);

  dynamic operator[](String key);
  void operator[]=(String key, dynamic value);
}

abstract class PostHandler {
  Future sendPost(String url, Map<String, String> parameters);
}
