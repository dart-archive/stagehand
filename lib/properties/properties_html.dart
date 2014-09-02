// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library stagehand.properties_html;

import 'dart:async';
import 'dart:convert' show JSON;
import 'dart:html';

import 'properties.dart';
export 'properties.dart';

// TODO: test the html version

/**
 * TODO: doc
 */
class PropertiesHtml extends Properties {
  static Future<PropertiesHtml> create(String name) {
    String str = window.localStorage[name];
    if (str == null || str.isEmpty) str = '{}';
    Map map = JSON.decode(str);
    return new Future.value(new PropertiesHtml._(name, map));
  }

  PropertiesHtml._(String name, Map other) : super(name) {
    // Copy the map.
    other.forEach((key, value) => this[key] = value);
    dirty = false;
  }

  Future flush() {
    window.localStorage[name] = JSON.encode(toMap());
    return new Future.value();
  }
}
