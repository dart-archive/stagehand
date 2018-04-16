// Copyright (c) 2015, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../src/common.dart';
import 'web_angular_data.dart';

/// A generator for an Angular 2 application.
class WebAngularGenerator extends DefaultGenerator {
  WebAngularGenerator()
      : super('web-angular', 'AngularDart Web App',
            'A web app with material design components.',
            categories: const ['dart', 'web']) {
    for (var file in decodeConcatenatedData(data)) {
      addTemplateFile(file);
    }

    setEntrypoint(getFile('web/index.html'));
  }
}
