// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// TODO: lots o' library docs
library stagehand;

import 'dart:collection';

import 'generators/helloworld.dart';
import 'generators/package.dart';
import 'generators/webapp.dart';
import 'src/generator.dart';

export 'src/file_contents.dart';
export 'src/generator.dart';
export 'src/generator_target.dart';
export 'src/template_file.dart';

/// A curated, prescriptive list of Dart project generators.
final List<Generator> generators = new UnmodifiableListView([
  new HelloWorldGenerator(),
  new WebAppGenerator(),
  new PackageGenerator()
]);

Generator getGenerator(String id) =>
    generators.firstWhere((g) => g.id == id, orElse: () => null);
