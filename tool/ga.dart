// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/**
 * A simple command-line app to hand-test the analytics library.
 */
library stagehand_ga;

import 'package:stagehand/analytics/analytics_io.dart';

void main() {
  Analytics ga = new AnalyticsIO('UA-55029513-1', 'ga_test', '1.0');
  ga.optIn = true;
  ga.sendScreenView('home');
  ga.sendScreenView('files');
  ga.sendException('foo exception, line 123:56');
  ga.sendEvent('create', 'consoleapp', 'Console App');
}
