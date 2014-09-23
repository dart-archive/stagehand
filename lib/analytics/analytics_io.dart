// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/**
 * TODO:
 */
library stagehand.analytics_io;

import 'dart:async';
import 'dart:convert' show JSON;
import 'dart:io';

import 'package:path/path.dart' as path;

import 'src/analytics_impl.dart';

export 'analytics.dart';

/**
 * TODO:
 */
class AnalyticsIO extends AnalyticsImpl {
  AnalyticsIO(String trackingId, String applicationName, String applicationVersion) :
    super(
      trackingId,
      new _PersistentProperties(applicationName),
      new _PostHandler(),
      applicationName: applicationName,
      applicationVersion: applicationVersion);
}

class _PostHandler extends PostHandler {
  String _userAgent;

  _PostHandler() {
    _userAgent = _createUserAgent();
  }

  Future sendPost(String url, Map<String, String> parameters) {
    String data = postEncode(parameters);

    // TODO: Should we try and re-use this client?
    HttpClient client = new HttpClient();
    client.userAgent = _userAgent;
    return client.postUrl(Uri.parse(url)).then((HttpClientRequest req) {
      req.write(data);
      return req.close();
    }).then((HttpClientResponse response) {
      response.drain();
    });
  }

  String _createUserAgent() {
    // Mozilla/5.0 (iPhone; U; CPU iPhone OS 5_1_1 like Mac OS X; en)
    String os = Platform.operatingSystem;
    String locale = Platform.environment['LANG'];
    return "Dart/${Platform.version} (${os}; ${os}; ${os}; ${locale})";
  }
}

class _PersistentProperties extends PersistentProperties {
  File _file;
  Map _map;

  _PersistentProperties(String name) : super(name) {
    String fileName = '.${name.replaceAll(' ', '_')}';
    _file = new File(path.join(_userHomeDir(), fileName));
    _file.createSync();
    String contents = _file.readAsStringSync();
    if (contents.isEmpty) contents = '{}';
    _map = JSON.decode(contents);
  }

  dynamic operator[](String key) => _map[key];

  void operator[]=(String key, dynamic value) {
    _map[key] = value;
    _file.writeAsStringSync(JSON.encode(_map) + '\n');
  }
}

String _userHomeDir() {
  String envKey = Platform.operatingSystem == 'windows' ? 'APPDATA' : 'HOME';
  String value = Platform.environment[envKey];
  return value == null ? '.' : value;
}
