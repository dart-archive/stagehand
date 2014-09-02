// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/**
 * TODO:
 */
library stagehand.analytics;

import 'dart:async';
import 'dart:math' as math;

// TODO: Under construction!

// TODO: store a generated anonymous client id

// TODO: store whether the user has opted in / out

// https://developers.google.com/analytics/devguides/collection/protocol/policy

class Analytics {
  static const String _GA_URL = 'https://www.google-analytics.com/collect';

  /// Tracking ID / Property ID.
  final String trackingId;
  final PropertiesHandler propertiesHandler;
  final PostHandler postHandler;
  final String applicationVersion;
  final String applicationId;

  /// Anonymous Client ID. The value of this field should be a random UUID
  /// (version 4).
  String _clientId;
  final _ThrottlingBucket _bucket = new _ThrottlingBucket(20);

  Analytics(this.trackingId, this.propertiesHandler, this.postHandler,
      {this.applicationVersion, this.applicationId}) {
    assert(trackingId != null);
  }

//  Future sendPageView() {
//
//  }

  Future sendScreenView() {
    // TODO:
    Map args = {};
    return _sendPayload('screenview', args);
  }

  Future sendEvent() {
    // TODO:
    return new Future.value();
  }

  Future sendException(String description, [bool fatal]) {
    Map args = {'exd': description};
    if (fatal != null && fatal) args['exf'] = '1';
    return _sendPayload('exception', args);
  }

  // Valid values for [hitType] are: 'pageview', 'screenview', 'event',
  // 'transaction', 'item', 'social', 'exception', and 'timing'.
  Future _sendPayload(String hitType, Map args) {
    assert(hitType != null);

    if (_bucket.removeDrop()) {
      args['v'] = '1'; // version
      args['tid'] = trackingId;
      args['cid'] = _clientId;
      args['t'] = hitType;

      if (applicationId != null) args['aid'] = applicationId;
      if (applicationVersion != null) args['av'] = applicationVersion;

      return postHandler.sendPost(_GA_URL, args);
    } else {
      return new Future.value();
    }
  }
}

/**
 * TODO:
 */
abstract class PropertiesHandler {
  dynamic getProperty(String key);
  void setProperty(String key, dynamic value);
}

/**
 * TODO:
 */
abstract class PostHandler {
  /**
   * TODO:
   */
  Future sendPost(String url, Map<String, String> parameters);
}

/**
 * A throttling algorithim. This models the throttling after a bucket with
 * water dripping into it at the rate of 1 drop per second. If the bucket has
 * water when an operation is requested, 1 drop of water is removed and the
 * operation is performed. If not the operation is skipped. This algorithim
 * lets operations be peformed in bursts without throttling, but holds the
 * overall average rate of operations to 1 per second.
 */
class _ThrottlingBucket {
  final int startingCount;
  int drops;
  int _lastReplenish;

  _ThrottlingBucket(this.startingCount) {
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
