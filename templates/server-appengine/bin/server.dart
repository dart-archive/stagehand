// Copyright (c) {{year}}, {{author}}. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:shelf/shelf.dart';
import 'package:shelf_appengine/shelf_appengine.dart' as shelf_ae;
import 'package:{{projectName}}/memcache.dart' as cache;

/// Application entry point called by AppEngine at startup.
main(List<String> args) async {
  var portArgs = args.where((a) => a.startsWith('--port=')).toList();

  int port = 8080;
  if (portArgs.length == 1) {
    var portArg = portArgs.single.substring(7);
    port = int.parse(portArg);
  }

  var cascade = new Cascade().add(_handler).add(shelf_ae.assetHandler(
      directoryIndexServeMode: shelf_ae.DirectoryIndexServeMode.SERVE));

  await shelf_ae.serve(cascade.handler, port: port);
}

Future<Response> _handler(Request request) async {
  await cache.initialize();

  if (request.method != "GET") {
    return new Response.forbidden(
        'Unsupported HTTP request method: ${request.method}');
  }

  if (request.url.pathSegments.length == 1) {
    switch (request.url.pathSegments.single) {
      case 'write_cache':
        return _writeCache(request.url.queryParameters);
      case 'read_cache':
        return _readCache(request.url.queryParameters);
      case 'clear_cache':
        return _clear();
    }
  }

  return new Response.notFound('sorry...');
}

Future<Response> _readCache(Map<String, String> parameters) async {
  var keys = parameters.keys.toList();

  var output = new StringBuffer();

  if (keys.isEmpty) {
    output.writeln(
        'Reading default key (${cache.DEFAULT_KEY}), since no keys provided.');
    output.writeln('');
    keys = const [cache.DEFAULT_KEY];
  } else {
    output.writeln('Reading ${parameters.length} value(s) from cache.');
    output.writeln('');
  }

  await cache.read(keys, output);

  return new Response.ok(output.toString());
}

Future<Response> _writeCache(Map<String, String> parameters) async {
  var output = new StringBuffer();

  // Update the cache with the given key/value pairs.
  output.writeln('Updating cache with ${parameters.length} value(s).');
  output.writeln('');

  await cache.write(parameters, output);

  return new Response.ok(output.toString());
}

Future<Response> _clear() async {
  await cache.clear();
  return new Response.ok('Cleared cache!');
}
