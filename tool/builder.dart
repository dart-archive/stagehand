// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';

import 'src/code_generator.dart';
import 'src/version_generator.dart';

Builder stagehandBuilder([_]) => new PartBuilder([
      new VersionGenerator(),
      new DataGenerator(),
    ], header: _fileHeader);

final _fileHeader = '''
// Copyright (c) 2018, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND
''';
