// Copyright (c) {{year}}, {{author}}. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:appengine/appengine.dart';

const String DEFAULT_KEY = 'hello';
bool cacheInitialized = false;

/// Application entrypoint called by AppEngine at startup.
main() {
  // Setup AppEngine and register an HTTP request handler.
  runAppEngine(requestHandler);
}

/// The main HTTP request handler.
void requestHandler(HttpRequest request) {
  // Initialize the application. This is done here since we can only access
  // the AppEngine APIs when in the context of a request. To avoid initializing
  // an already initialized app it is guarded by the [cacheInitialized] bool.
  var initialized = new Future.sync(initializeCache);

  initialized.then((_) {
    // We only handle GET requests in this simple example.
    if (request.method == 'GET') {
      handleGetRequest(request);
    } else {
      request.response
        ..statusCode = HttpStatus.METHOD_NOT_ALLOWED
        ..write('Unsupported HTTP request method: ${request.method}.')
        ..close();
    }
  }).catchError((_) => request.response
      ..write('Failed handling request: ${request.toString()}.')
      ..close());
}

/// Initialize the application.
Future initializeCache() {
  // If the cache is already initialized, just return.
  if (cacheInitialized) {
    return new Future.value();
  }

  // The AppEngine environment has a preconfigured 'context' which provides
  // authorized access to the default api services.
  var memcache = context.services.memcache;

  // Initialize the cache and set the default value.
  return memcache.clear()
      .then((_) => memcache.set(DEFAULT_KEY, 'there!'))
      .then((_) => cacheInitialized = true);
}

/// GET request handler.
///
/// Parses the url to determine what command to run and the corresponding
/// input data.
handleGetRequest(HttpRequest request) {
  HttpResponse response = request.response;
  // Determine command.
  if (request.uri.path == '/write_cache') {
    // Get the parsed query string.
    Map<String, String> queryMap = request.uri.queryParameters;
    // Update the cache with the given key/value pairs.
    response.writeln('Updating cache with ${queryMap.length} value(s).');
    response.writeln('');
    write_cache(response, queryMap);
  } else if (request.uri.path == '/read_cache') {
    // If no query string is given return the default key's value.
    if (!request.uri.hasQuery) {
      response.writeln('Reading default value, since no keys provided.');
      response.writeln('');
      read_cache(response, [DEFAULT_KEY]);
      return;
    }
    // Get the parsed query string.
    Map<String, String> queryMap = request.uri.queryParameters;
    // Read out the values corresponding to the keys in the query string.
    response.writeln('Reading ${queryMap.length} value(s) from cache.');
    response.writeln('');
    read_cache(response, queryMap.keys);
  } else if (request.uri.path == '/clear_cache') {
    // Reintialize the cache. This clears all values and resets the default.
    cacheInitialized = false;
    initializeCache()
      .then((_) => response.writeln('Cleared cache!'))
      .whenComplete(response.close);
  } else {
    // Serve some static content. This must be located in 'build/web' or some
    // subdirectory of 'build/web'.
    context.assets.serve('/usage.html');
  }
}

/// Helper method to write a set of key/value pairs to the memcache.
void write_cache(HttpResponse response, Map<String, String> valueMap) {
  var memcache = context.services.memcache;
  Future.forEach(valueMap.keys, (key) {
    var value = valueMap[key];
    return memcache.set(key, value)
        .then((_) => response.writeln('"${key}": "${value}"'));
  }).whenComplete(response.close);
}

/// Helper method to read a set of values from the memcache.
void read_cache(HttpResponse response, Iterable<String> keys) {
  var memcache = context.services.memcache;
  Future.forEach(keys, (key) => memcache.get(key)
      .then((value) => response.writeln('"${key}": "${value}"'))
      .catchError((_) => response.writeln('"${key}": value not found!')))
    .whenComplete(response.close);
}

/// Helper method to print the application usage information.
void printUsage(HttpResponse response) {
  response
      ..writeln('This application implements a simple key/value cache.')
      ..writeln('')
      ..writeln('The following commands are supported:')
      ..writeln('<base-url>/write_cache?<key1>=<value1>&<key2>=<value2> '
                '- Updates the cache with two key/value pairs. Any '
                'number of key/value pairs can be given.')
      ..writeln('<base-url>/read_cache?<key1>&<key2>                    '
                '- Reads back the values corresponding to the given keys.')
      ..writeln('<base-url>/clear_cache                                 '
                '- Clears the cache and sets the initial key/value pair')
      ..close();
}
