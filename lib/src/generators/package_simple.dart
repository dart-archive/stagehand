// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../common.dart';

part 'package_simple.g.dart';

/// A generator for a pub library.
class PackageSimpleGenerator extends DefaultGenerator {
  PackageSimpleGenerator()
      : super('package-simple', 'Dart Package',
            'A starting point for Dart libraries or applications.',
            categories: const ['dart']) {
    for (var file in decodeConcatenatedData(_data)) {
      addTemplateFile(file);
    }

    setEntrypoint(getFile('lib/__projectName__.dart'));
  }
}
