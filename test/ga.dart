// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:stagehand/analytics/analytics_io.dart';

void main() {
  Analytics ga = new Analytics('UA-55029513-1',
      new PropertiesHandlerIO('ga_test'),
      new PostHandlerIO());
      //new MockPostHandler(true));
  ga.sendScreenView('home');
  ga.sendScreenView('files');
  ga.sendException('foo exception, line 123:56');
}
