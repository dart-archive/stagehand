// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:grinder/grinder.dart';

main(List<String> args) => grind(args);

@Task('Run each generator and analyze the output')
test() => new TestRunner().testAsync(files: 'test/validate_templates.dart');
