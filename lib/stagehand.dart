// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/**
 * TODO: lots o' library docs
 */
library stagehand;

import 'dart:async';
import 'dart:convert';

import 'generators/consoleapp.dart';
import 'generators/webapp.dart';
import 'generators/package.dart';
import 'generators/polymer.dart';
import 'src/common.dart';

/// A curated, prescriptive list of Dart project generators.
final List<Generator> generators = [
  new ConsoleAppGenerator(),
  new WebAppGenerator(),
  new PackageGenerator(),
  new PolymerGenerator()
];

Generator getGenerator(String id) {
  return generators.firstWhere((g) => g.id == id, orElse: () => null);
}

/**
 * TODO: doc
 */
abstract class Generator {
  static int compareGenerators(Generator a, Generator b) =>
      a.id.toLowerCase().compareTo(b.id.toLowerCase());

  final String id;
  final String description;
  final List<String> categories;

  final List<TemplateFile> files = [];
  TemplateFile _entrypoint;

  Generator(this.id, this.description, {this.categories: const []});

  /**
   * The entrypoint of the application; the main file for the project, which an
   * IDE might open after creating the project.
   */
  TemplateFile get entrypoint => _entrypoint;

  /**
   * TODO:
   */
  TemplateFile addTemplateFile(TemplateFile file) {
    files.add(file);
    return file;
  }

  /**
   * Return the template file wih the given [path].
   */
  TemplateFile getFile(String path) {
    return files.firstWhere((file) => file.path == path, orElse: () => null);
  }

  /**
   * TODO: doc
   * TODO: consider passing this to the constructor
   */
  void setEntrypoint(TemplateFile entrypoint) {
    if (_entrypoint != null) throw new StateError('entrypoint already set');
    if (entrypoint == null) throw new StateError('entrypoint is null');
    this._entrypoint = entrypoint;
  }

  Future generate(String projectName, GeneratorTarget target) {
    Map vars = {
      'projectName': projectName,
      'description': description,
      'year': new DateTime.now().year.toString()
    };

    return Future.forEach(files, (TemplateFile file) {
      var resultFile = file.runSubstitution(vars);
      String filePath = resultFile.path;
      filePath = filePath.replaceAll('projectName', projectName);
      return target.createFile(filePath, resultFile.content);
    });
  }

  int numFiles() => files.length;

  String toString() => '[${id}: ${description}]';
}

/**
 * A target for a [Generator]. This class knows how to create files given a path
 * for the file (relavtive to the particular [GeneratorTarget] instance), and
 * the binary content for the file.
 */
abstract class GeneratorTarget {
  /**
   * Create a file at the given path with the given contents.
   */
  Future createFile(String path, List<int> contents);
}

/**
 * This class represents a file in a generator template. The contents could
 * either be binary or text. If text, the contents may contain mustache
 * variables that can be substituted (`{{myVar}}`).
 */
class TemplateFile {
  final String path;
  final String content;

  List<int> _binaryData;

  TemplateFile(this.path, this.content);

  TemplateFile.fromBinary(this.path, this._binaryData) : this.content = null;

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
      return UTF8.encode(substituteVars(content, vars));
    }
  }
}

class FileContents {
  final String path;
  final List<int> content;

  FileContents(this.path, this.content);
}
