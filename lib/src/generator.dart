// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:async';

import 'generator_target.dart';
import 'template_file.dart';


// TODO: doc
abstract class Generator implements Comparable<Generator> {
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

  // TODO: docs
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

  // TODO: doc
  // TODO: consider passing this to the constructor
  void setEntrypoint(TemplateFile entrypoint) {
    if (_entrypoint != null) throw new StateError('entrypoint already set');
    if (entrypoint == null) throw new StateError('entrypoint is null');
    this._entrypoint = entrypoint;
  }

  Future generate(String projectName, GeneratorTarget target) {
    Map vars = {
      'projectName': projectName,
      'description': description,
    };

    return Future.forEach(files, (TemplateFile file) {
      var resultFile = file.runSubstitution(vars);
      return target.createFile(resultFile.path, resultFile.content);
    });
  }

  int numFiles() => files.length;

  String toString() => '[${id}: ${description}]';

  int compareTo(Generator other) => this.id.toLowerCase().compareTo(other.id.toLowerCase());
}
