// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library stagehand.properties;

import 'dart:async';

/**
 * TODO: doc
 */
abstract class Properties {
  final String name;
  final Map<String, dynamic> _map = {};
  bool dirty = false;

  Properties(this.name);

  /**
   * Get the value for the given key. This is an alias for the index operator to
   * aid in discoverability.
   */
  dynamic getValue(String key) => this[key];

  /**
   * Set the value for the given key. This is an alias for the index operator to
   * aid in discoverability.
   */
  void setValue(String key, dynamic value) => this[key] = value;

  dynamic operator[](String key) => _map[key];

  void operator[]=(String key, dynamic value) {
    dirty = true;
    _map[key] = value;
  }

  Future flush();

  Map<String, dynamic> toMap() => new Map.from(_map);

  String toString() => '${name} properties';
}
