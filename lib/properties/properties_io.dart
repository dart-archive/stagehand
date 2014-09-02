// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library stagehand.properties_io;

import 'dart:async';
import 'dart:convert' show JSON;
import 'dart:io';

import 'package:path/path.dart' as path;

import 'properties.dart';
export 'properties.dart';

/**
 * TODO: doc
 */
class PropertiesIo extends Properties {
  static Future<PropertiesIo> create(String name) {
    String filename = '.${name.replaceAll(' ', '_')}';
    File file = new File(path.join(_userHomeDir(), filename));

    return file.create().then((_) {
      return file.readAsString();
    }).then((String contents) {
      if (contents.isEmpty) contents = '{}';
      Map map = JSON.decode(contents);
      return new PropertiesIo._(name, file, map);
    });
  }

  final File file;

  PropertiesIo._(String name, this.file, Map other) : super(name) {
    // Copy the map.
    other.forEach((key, value) => this[key] = value);
    dirty = false;
  }

  Future flush() {
    return file.writeAsString(JSON.encode(toMap())).then((_) {
      dirty = false;
    });
  }
}

String _userHomeDir() {
  String envKey = Platform.operatingSystem == 'windows' ? 'APPDATA' : 'HOME';
  String value = Platform.environment[envKey];
  return value == null ? '.' : value;
}
