// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.9
<<<<<<< HEAD

=======
>>>>>>> ff7988e6909007c22f00c25053b4e14461444421
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/code_generator.dart';

Builder stagehandBuilder([_]) => PartBuilder([
      DataGenerator(),
    ], '.g.dart');
