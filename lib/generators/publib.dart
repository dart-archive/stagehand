// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library stagehand.publib;

import '../src/common.dart';

/**
 * A generator for a pub library.
 */
class PubLibGenerator extends DefaultGenerator {
  PubLibGenerator() : super(
      'publib',
      "A library useful for applications or for sharing on pub.dartlang.org.",
      categories: const ['dart']) {

    // TODO: add test/ contents
    addFile('CHANGELOG.md', _changelog);
    addFile('pubspec.yaml', _pubspec);
    addFile('README.md', _readme);
    addFile('example/{{projectName}}.dart', _example);
    setEntrypoint(addFile('lib/{{projectName}}.dart', _lib));
    addFile('lib/src/{{projectName}}_impl.dart', _srcLib);
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

library {{projectName}};

import 'src/{{projectName}}_impl.dart';

class Awesome {

}
''';

  String get _srcLib => '''
// Copyright (c) ${new DateTime.now().year}, the {{projectName}} project
// authors. Please see the AUTHORS file for details. All rights reserved. Use
// of this source code is governed by a BSD-style license that can be found
// in the LICENSE file.

library {{projectName}}_impl;

class DefaultAwesome extends Awesome {

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
}
''';
}
