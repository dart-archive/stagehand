// Copyright (c) {{year}}, {{author}}. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:appengine/appengine.dart';
import 'package:{{projectName}}/memcache.dart' as cache;

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
  var initialized = new Future.sync(cache.initialize);

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
    cache.write(response, queryMap);
  } else if (request.uri.path == '/read_cache') {
    // If no query string is given return the default key's value.
    if (!request.uri.hasQuery) {
      response.writeln('Reading default value, since no keys provided.');
      response.writeln('');
      cache.read(response, [cache.DEFAULT_KEY]);
      return;
    }
    // Get the parsed query string.
    Map<String, String> queryMap = request.uri.queryParameters;
    // Read out the values corresponding to the keys in the query string.
    response.writeln('Reading ${queryMap.length} value(s) from cache.');
    response.writeln('');
    cache.read(response, queryMap.keys);
  } else if (request.uri.path == '/clear_cache') {
    // Reintialize the cache. This clears all values and resets the default.
    cache
        .clear()
        .then((_) => response.writeln('Cleared cache!'))
        .whenComplete(response.close);
  } else {
    // Serve some static content. This must be located in 'build/web' or some
    // subdirectory of 'build/web'.
    context.assets.serve('/usage.html');
  }
}
