// Copyright (c) {{year}}, {{author}}. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library {{projectName}}.memcache;

import 'dart:async';

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
Future write(Map<String, String> valueMap, StringSink buffer) async {
  var memcache = context.services.memcache;

  for (var key in valueMap.keys) {
    var value = valueMap[key];

    await memcache.set(key, value);

    buffer.writeln('${key}: ${Error.safeToString(value)}');
  }
}

/// Helper method to read a set of values from the memcache.
Future read(Iterable<String> keys, StringSink buffer ) async {
  var memcache = context.services.memcache;

  for (var key in keys) {
    try {
      var value = await memcache.get(key);
      buffer.writeln('${key}: ${Error.safeToString(value)}');
    } catch (_) {
      buffer.writeln('"${key}": error reading key!');
    }
  }
}
