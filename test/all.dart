// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'cli_test.dart' as cli_test;
import 'common_test.dart' as common_test;
import 'generators_test.dart' as generators_test;
import 'mock_test.dart' as mock_test;

void main() {
  cli_test.main();
  common_test.main();
  generators_test.main();
  mock_test.main();
}
