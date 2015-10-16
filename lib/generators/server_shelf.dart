// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library stagehand.server.shelf;

import '../stagehand.dart';
import '../src/common.dart';
import 'server_shelf_data.dart';

/**
 * A generator for a hello world command-line application.
 */
class ServerShelfGenerator extends DefaultGenerator {
  ServerShelfGenerator()
      : super('server-shelf', 'Shelf Web Server',
            'A web server built using the shelf package.',
            categories: const ['dart', 'shelf', 'server']) {
    for (TemplateFile file in decodeConcatenatedData(data)) {
      addTemplateFile(file);
    }

    setEntrypoint(getFile('bin/server.dart'));
  }

  String getInstallInstructions() => "${super.getInstallInstructions()}\n"
      "run your app via 'dart ${entrypoint.path}'";
}
