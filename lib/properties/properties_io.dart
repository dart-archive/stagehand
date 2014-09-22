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
class PropertiesIO extends Properties {
  static PropertiesIO create(String name) {
    String filename = '.${name.replaceAll(' ', '_')}';
    File file = new File(path.join(_userHomeDir(), filename));

    file.createSync();
    String contents = file.readAsStringSync();
    if (contents.isEmpty) contents = '{}';
    Map map = JSON.decode(contents);
    return new PropertiesIO._(name, file, map);
  }

  final File file;

  PropertiesIO._(String name, this.file, Map other) : super(name) {
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
