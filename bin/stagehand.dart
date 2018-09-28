// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io' as io;

import 'package:stagehand/stagehand.dart';
import 'package:stagehand/src/cli_app.dart';
import 'package:usage/usage_io.dart';

void main(List<String> args) {
  var app = CliApp(generators, CliLogger());

  try {
    app.process(args).catchError((Object e, StackTrace st) {
      if (e is ArgError) {
        // These errors are expected.
        io.exit(1);
      } else {
        print('Unexpected error: $e\n$st');

        _sendException(app.analytics, e, st).then((_) {
          io.exit(1);
        });
      }
    }).whenComplete(() {
      // Always exit quickly after performing work. If the user has opted into
      // analytics, the analytics I/O can cause the CLI to wait to terminate.
      // This is annoying to the user, as the tool has already completed its
      // work from their perspective.
      io.exit(0);
    });
  } catch (e, st) {
    print('Unexpected error: $e\n$st');
    _sendException(app.analytics, e, st);
  }
}

Future _sendException(Analytics analytics, Object e, StackTrace st) {
  // Sanitize (file:///Users/user/tmp/error.dart:3:13) to (error.dart:3:13).
  var str = sanitizeStacktrace(st);
  if (e != null) str = '${e.runtimeType}: $str';
  return analytics.sendException(str, fatal: true);
}
