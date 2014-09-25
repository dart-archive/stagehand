// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library stagehand.package;

import '../src/common.dart';

/**
 * A generator for a pub library.
 */
class PackageGenerator extends DefaultGenerator {
  PackageGenerator() : super(
      'package',
      "A library useful for applications or for sharing on pub.dartlang.org.",
      categories: const ['dart']) {

    addFile('CHANGELOG.md', _changelog);
    addFile('pubspec.yaml', _pubspec);
    addFile('README.md', _readme);
    addFile('example/{{projectName}}.dart', _example);
    setEntrypoint(addFile('lib/{{projectName}}.dart', _lib));
    addFile('lib/src/{{projectName}}_base.dart', _baseLib);
    addFile('test/all_test.dart', _unitTest);
  }

  String get _pubspec => '''
name: {{projectName}}
description: >
${convertToYamlMultiLine(description)}
version: 0.0.1
#author: First Last <email@example.com>
#homepage: https://www.example.com
#dependencies:
#  lib_name: any
dev_dependencies:
  unittest: any
''';

  String get _readme => '''
# {{projectName}}

A library for Dart developers. It is awesome.

## Usage

A simple usage example:

    import 'package:{{projectName}}/{{projectName}}.dart';

    main() {
      var awesome = new Awesome();
    }

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: http://example.com/issues/replaceme
''';

  String get _changelog => '''
# Changelog

## 0.0.1

* Initial project creation
''';

  String get _lib => '''
// Copyright (c) ${new DateTime.now().year}, the {{projectName}} project
// authors. Please see the AUTHORS file for details. All rights reserved. Use
// of this source code is governed by a BSD-style license that can be found
// in the LICENSE file.

/// The {{projectName}} library.
///
/// This is an awesome library. More dartdocs go here.
library {{projectName}};

// TODO: Export any libraries intended for clients of this package.

export 'src/{{projectName}}_base.dart';
''';

  String get _baseLib => '''
// Copyright (c) ${new DateTime.now().year}, the {{projectName}} project
// authors. Please see the AUTHORS file for details. All rights reserved. Use
// of this source code is governed by a BSD-style license that can be found
// in the LICENSE file.

// TODO: Put public facing types in this file.

library {{projectName}}.base;

/// Checks if you are awesome. Spoiler: you are.
class Awesome {
  bool get isAwesome => true;
}
''';

  String get _example => '''
// Copyright (c) ${new DateTime.now().year}, the {{projectName}} project
// authors. Please see the AUTHORS file for details. All rights reserved. Use
// of this source code is governed by a BSD-style license that can be found
// in the LICENSE file.

library {{projectName}}.example;

import 'package:{{projectName}}/{{projectName}}.dart';

main() {
  var awesome = new Awesome();
  print(awesome.isAwesome);
}
''';

  String get _unitTest => '''
// Copyright (c) ${new DateTime.now().year}, the {{projectName}} project
// authors. Please see the AUTHORS file for details. All rights reserved. Use
// of this source code is governed by a BSD-style license that can be found
// in the LICENSE file.

library {{projectName}}.test;

import 'package:unittest/unittest.dart';
import 'package:{{projectName}}/{{projectName}}.dart';

main() {
  group('A group of tests', () {
    Awesome awesome;

    setUp(() {
      awesome = new Awesome();
    });

    test('First Test', () {
      expect(awesome.isAwesome, isTrue);
    });
  });
}
''';
}
