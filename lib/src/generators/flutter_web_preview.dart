// Copyright (c) 2019, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../common.dart';

part 'flutter_web_preview.g.dart';

/// A generator for a Flutter web application.
class FlutterWebPreviewGenerator extends DefaultGenerator {
  FlutterWebPreviewGenerator()
      : super('flutter-web-preview', 'Flutter Web App',
            'A simple Flutter Web app.',
            categories: const ['dart', 'web', 'flutter']) {
    for (var file in decodeConcatenatedData(_data)) {
      addTemplateFile(file);
    }

    setEntrypoint(getFile('web/index.html'));
  }
}
