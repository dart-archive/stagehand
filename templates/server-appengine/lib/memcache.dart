// Copyright (c) {{year}}, {{author}}. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library {{projectName}}.memcache;

import 'dart:async';
import 'dart:io';

import 'package:appengine/appengine.dart';

const String DEFAULT_KEY = 'hello';
bool cacheInitialized = false;

/// Initialize the cache.
Future initialize() async {
  // If the cache is already initialized, just return.
  if (cacheInitialized) return;

  // The AppEngine environment has a preconfigured 'context' which provides
  // authorized access to the default api services.
  var memcache = context.services.memcache;

  // Initialize the cache and set the default value.
  await memcache.clear();
  await memcache.set(DEFAULT_KEY, 'there!');
  cacheInitialized = true;
}

/// Clears the cache and resets the default.
Future clear() async {
  cacheInitialized = false;
  await initialize();
}

/// Helper method to write a set of key/value pairs to the memcache.
void write(HttpResponse response, Map<String, String> valueMap) {
  var memcache = context.services.memcache;
  Future.forEach(valueMap.keys, (key) {
    var value = valueMap[key];
    return memcache
        .set(key, value)
        .then((_) => response.writeln('"${key}": "${value}"'));
  }).whenComplete(response.close);
}

/// Helper method to read a set of values from the memcache.
void read(HttpResponse response, Iterable<String> keys) {
  var memcache = context.services.memcache;
  var handleKey = (key) => memcache
      .get(key)
      .then((value) => response.writeln('"${key}": "${value}"'))
      .catchError((_) => response.writeln('"${key}": value not found!'));
  Future.forEach(keys, handleKey).whenComplete(response.close);
}
