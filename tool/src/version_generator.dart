// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:yaml/yaml.dart';

class VersionGenerator extends Generator {
  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    if (buildStep.inputId.pathSegments.last != 'cli_app.dart') {
      return null;
    }

    var content = await buildStep
        .readAsString(new AssetId(buildStep.inputId.package, 'pubspec.yaml'));

    var yaml = loadYaml(content) as Map;

    var versionString = yaml['version'] as String;

    return '''
const appVersion = '$versionString';
''';
  }
}
