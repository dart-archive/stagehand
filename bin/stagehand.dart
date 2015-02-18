// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library stagehand.cli;

import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart' as path;
import 'package:plugins/loader.dart';
import 'package:stagehand/src/build_generator.dart';
import 'package:stagehand/stagehand.dart';
import 'package:stagehand/src/cli_app.dart';
import 'package:usage/usage_io.dart';

void main(List<String> args) {
  // Determine the user home directory
  Map<String, String> envVars = io.Platform.environment;
  String homeDir = envVars['HOME'];
  int noOfPluginDirs = 0;
  int noOfTimesloadPluginCalled = 0;
  // stagehandData is the plugin directory
  io.Directory dirpath = new io.Directory(path.join(homeDir, 'stagehandData'));
  if (dirpath.existsSync()) {
    List<io.FileSystemEntity> dirList = dirpath.listSync(recursive: false, followLinks: false);
    for (io.FileSystemEntity f in dirList) {
      if (io.FileSystemEntity.isDirectorySync(f.path)) {
        noOfPluginDirs += 1;
        PluginManager pm = new PluginManager();
        io.Directory extpath = new io.Directory(f.path);
        pm.loadAll(extpath).then((_) {
          pm.listenAll((name, data) {
            noOfTimesloadPluginCalled += 1;
            var newGenerator = new PluginGenerator(name, data);
            generators.add(newGenerator);
            pm.killAll();
            // This means the last listen event got called
            if (noOfTimesloadPluginCalled == noOfPluginDirs) {
              mainRoutine(args);
            }
          });
          // Activate the listeners
          pm.sendAll(new Map());
        });
      }
    }
  }
  // No plugins found
  if (noOfPluginDirs == 0) {
    mainRoutine(args);
  }

}

void mainRoutine(List<String> args) {
  CliApp app = new CliApp(generators, new CliLogger());
  try {
    app.process(args).catchError((e, st) {
      if (e is ArgError) {
        // These errors are expected.
        io.exit(1);
      } else {
        print('Unexpected error: ${e}\n${st}');

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
    print('Unexpected error: ${e}\n${st}');
    _sendException(app.analytics, e, st);
  }
}

Future _sendException(Analytics analytics, var e, var st) {
  // Sanitize (file:///Users/user/tmp/error.dart:3:13) to (error.dart:3:13).
  String str = sanitizeStacktrace(st);
  if (e != null) str = '${e.runtimeType}: ${str}';
  return analytics.sendException(str, fatal: true);
}
