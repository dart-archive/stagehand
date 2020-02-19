// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../common.dart';

part 'web_stagexl.g.dart';

/// A generator for a StageXL web application.
class WebStageXlGenerator extends DefaultGenerator {
  WebStageXlGenerator()
      : super('web-stagexl', 'StageXL Web App',
            'A starting point for 2D animation and games.',
            categories: const ['dart', 'web']) {
    for (var file in decodeConcatenatedData(_data)) {
      addTemplateFile(file);
    }

    setEntrypoint(getFile('web/index.html'));
  }
}
