// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/**
 * TODO:
 */
library stagehand.analytics_html;

import 'dart:async';
import 'dart:convert' show JSON;
import 'dart:html';

import 'src/analytics_impl.dart';

export 'analytics.dart';

class AnalyticsHtml extends AnalyticsImpl {
  AnalyticsHtml(String trackingId, String applicationName, String applicationVersion) :
    super(
      trackingId,
      new _PersistentProperties(applicationName),
      new _PostHandler(),
      applicationName: applicationName,
      applicationVersion: applicationVersion);
}

class _PostHandler extends PostHandler {
  Future sendPost(String url, Map<String, String> parameters) {
    String data = postEncode(parameters);
    return HttpRequest.request(url, method: "POST", sendData: data);
  }
}

class _PersistentProperties extends PersistentProperties {
  Map _map;

  _PersistentProperties(String name) : super(name) {
    String str = window.localStorage[name];
    if (str == null || str.isEmpty) str = '{}';
    _map = JSON.decode(str);
  }

  dynamic operator[](String key) => _map[key];

  void operator[]=(String key, dynamic value) {
    _map[key] = value;
    window.localStorage[name] = JSON.encode(_map);
  }
}
