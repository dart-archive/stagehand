// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library stagehand.template_file;

import 'dart:convert';

import 'common.dart';
import 'file_contents.dart';

/**
 * This class represents a file in a generator template. The contents could
 * either be binary or text. If text, the contents may contain mustache
 * variables that can be substituted (`{{myVar}}`).
 */
class TemplateFile {
  final String path;
  final String _content;
  final List<int> _binaryData;

  TemplateFile(this.path, this._content) : this._binaryData = null;

  TemplateFile.fromBinary(this.path, this._binaryData) : this._content = null;

  FileContents runSubstitution(Map parameters) {
    var newPath = substituteVars(path, parameters);
    var newContents = _createContent(parameters);

    return new FileContents(newPath, newContents);
  }

  bool get isBinary => _binaryData != null;

  List<int> _createContent(Map vars) {
    if (isBinary) {
      return _binaryData;
    } else {
      return UTF8.encode(substituteVars(_content, vars));
    }
  }
}
