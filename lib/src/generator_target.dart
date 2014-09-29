// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library stagehand.generator_target;

import 'dart:async';

/**
 * A target for a [Generator]. This class knows how to create files given a path
 * for the file (relavtive to the particular [GeneratorTarget] instance), and
 * the binary content for the file.
 */
abstract class GeneratorTarget {
  /**
   * Create a file at the given path with the given contents.
   */
  Future createFile(String path, List<int> contents);
}
