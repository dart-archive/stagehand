// Copyright (c) 2018, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:build/build.dart';
import 'package:path/path.dart' as p;
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';

const List<String> _allowedDotFiles = const <String>['.gitignore'];
final RegExp _binaryFileTypes = new RegExp(
    r'\.(jpe?g|png|gif|ico|svg|ttf|eot|woff|woff2)$',
    caseSensitive: false);

class DataGenerator extends Generator {
  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    if (!p.isWithin('lib/generators', buildStep.inputId.path)) {
      return null;
    }

    if (buildStep.inputId.path.endsWith('_data.dart')) {
      log.warning('temporary excluding ${buildStep.inputId.path}');
      return null;
    }

    var name =
        p.basenameWithoutExtension(buildStep.inputId.path).replaceAll('_', '-');

    var filteredAssets = await buildStep
        .findAssets(new Glob('templates/$name/**'))
        .where((asset) {
      var rootSegment = asset.pathSegments[2];

      if (rootSegment == 'build' || rootSegment == 'pubspec.lock') {
        return false;
      }

      if (_allowedDotFiles.contains(rootSegment)) {
        return true;
      }

      return !rootSegment.startsWith('.');
    }).toList()
      ..sort();

    var items = await _getLines(filteredAssets, buildStep).map((item) {
      if (item.contains('\n')) {
        return "'''\n$item'''";
      }
      return "'$item'";
    }).join(',');

    return 'const _data = const <String>[$items];';
  }
}

Stream<String> _getLines(List<AssetId> ids, AssetReader reader) async* {
  for (var id in ids) {
    yield p.url.joinAll(id.pathSegments.skip(2));
    yield _binaryFileTypes.hasMatch(p.basename(id.path)) ? 'binary' : 'text';
    yield _base64encode(await reader.readAsBytes(id));
  }
}

String _base64encode(List<int> bytes) {
  var encoded = base64.encode(bytes);

//
// Logic to cut lines into 76-character chunks
// – makes for prettier source code
//
  var lines = <String>[];
  var index = 0;

  while (index < encoded.length) {
    var line = encoded.substring(index, math.min(index + 76, encoded.length));
    lines.add(line);
    index += line.length;
  }

  return lines.join('\r\n');
}
