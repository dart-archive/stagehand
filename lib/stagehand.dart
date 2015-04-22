// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/**
 * Stagehand is a Dart project generator.
 *
 * Stagehand helps you get your Dart projects set up and ready for the big show.
 * It is a Dart project scaffolding generator, inspired by tools like Web
 * Starter Kit and Yeoman.
 *
 * It can be used as a command-line application, or as a regular Dart library
 * composed it a larger development tool. To use as a command-line app, run:
 *
 *     `pub global run stagehand`
 *
 * to see a list of all app types you can create, and:
 *
 *     `mkdir foobar; cd foobar`
 *     `pub global run stagehand webapp`
 *
 * to create a new instance of the `webapp` template in a `foobar` directory.
 */
library stagehand;

import 'dart:async';
import 'dart:convert';

import 'generators/appengineapp.dart';
import 'generators/console_full.dart';
import 'generators/webapp.dart';
import 'generators/web_polymer.dart';
import 'generators/package_simple.dart';
import 'generators/server_shelf.dart';
import 'generators/web_simple.dart';
import 'src/common.dart';

/// A curated, prescriptive list of Dart project generators.
final List<Generator> generators = [
  new AppEngineAppGenerator(),
  new ConsoleAppGenerator(),
  new WebPolymerAppGenerator(),
  new PackageSimpleGenerator(),
  new ShelfGenerator(),
  new WebAppGenerator(),
  new WebSimpleAppGenerator()
]..sort();

Generator getGenerator(String id) {
  return generators.firstWhere((g) => g.id == id, orElse: () => null);
}

/**
 * An abstract class which both defines a template generator and can generate a
 * user project based on this template.
 */
abstract class Generator implements Comparable<Generator> {
  final String id;
  final String label;
  final String description;
  final List<String> categories;

  final List<TemplateFile> files = [];
  TemplateFile _entrypoint;

  Generator(this.id, this.label, this.description, {this.categories: const []});

  /**
   * The entrypoint of the application; the main file for the project, which an
   * IDE might open after creating the project.
   */
  TemplateFile get entrypoint => _entrypoint;

  /**
   * Add a new template file.
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
   * Set the main entrypoint of this template. This is the 'most important' file
   * of this template. An IDE might use this information to open this file after
   * the user's project is generated.
   */
  void setEntrypoint(TemplateFile entrypoint) {
    if (_entrypoint != null) throw new StateError('entrypoint already set');
    if (entrypoint == null) throw new StateError('entrypoint is null');
    this._entrypoint = entrypoint;
  }

  Future generate(String projectName, GeneratorTarget target,
      {Map<String, String> additionalVars}) {
    Map vars = {
      'projectName': projectName,
      'description': description,
      'year': new DateTime.now().year.toString()
    };

    if (additionalVars != null) {
      additionalVars.keys.forEach((key) {
        vars[key] = additionalVars[key];
      });
    }

    if (!vars.containsKey('author')) {
      vars['author'] = '<your name>';
    }

    return Future.forEach(files, (TemplateFile file) {
      var resultFile = file.runSubstitution(vars);
      String filePath = resultFile.path;
      filePath = filePath.replaceAll('projectName', projectName);
      return target.createFile(filePath, resultFile.content);
    });
  }

  int numFiles() => files.length;

  int compareTo(Generator other) =>
      this.id.toLowerCase().compareTo(other.id.toLowerCase());

  /**
   * Return some user facing instructions about how to finish installation of
   * the template.
   */
  String getInstallInstructions() => '';

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
