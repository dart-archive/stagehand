// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/**
 * TODO:
 */
library stagehand.analytics_io;

import 'dart:async';
import 'dart:io';

import 'analytics.dart';
import '../properties/properties_io.dart';

export 'analytics.dart';

/**
 * TODO:
 */
class PostHandlerIO extends PostHandler {
  Future sendPost(String url, Map<String, String> parameters) {
    String data = postEncode(parameters);

    HttpClient client = new HttpClient();
    return client.postUrl(Uri.parse(url)).then((HttpClientRequest req) {
      req.write(data);
      return req.close();
    }).then((HttpClientResponse response) {
      response.drain();
    });
  }
}

class PropertiesHandlerIO implements PropertiesHandler {
  Properties props;

  PropertiesHandlerIO(String name) {
    props = PropertiesIO.create('.${name}');
  }

  dynamic getProperty(String key) => props.getValue(key);

  void setProperty(String key, dynamic value) {
    props.setValue(key, value);
    props.flush();
  }
}
