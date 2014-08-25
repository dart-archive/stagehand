//  Copyright (c) 2014, Stagehand project authors.
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//  * Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in the
//  documentation and/or other materials provided with the distribution.
//  * Neither the name of the <organization> nor the
//  names of its contributors may be used to endorse or promote products
//  derived from this software without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
//  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

/**
 * TODO: lots o' library docs
 */
library stagehand;

import 'dart:async';
import 'dart:convert';

import 'generators/helloworld.dart';
import 'generators/webapp.dart';
import 'src/common.dart';

/// A curated, prescriptive list of Dart project generators.
final List<Generator> generators = [
  new HelloWorldGenerator(), 
  new WebAppGenerator()
];

Generator getGenerator(String id) {
  return generators.firstWhere((g) => g.id == id, orElse: () => null);
}

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
  TemplateFile addFile(TemplateFile file) {
    files.add(file);
    return file;
  }
  
  void setEntrypoint(TemplateFile entrypoint) {
    assert(this._entrypoint == null);
    this._entrypoint = entrypoint;
  }
  
  Future generate(String directoryName, GeneratorTarget target) {
    Map vars = {'projectName': directoryName};
    
    return Future.forEach(files, (TemplateFile file) {
      return target.createFile(file.path, file.createContent(vars));
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
  final bool isBinary;
  
  TemplateFile(this.path, this.content, [this.isBinary = false]);

  List<int> createContent(Map vars) {
    if (isBinary) {
      return decodeBinary();
    } else {
      return UTF8.encode(substituteVars(content, vars));
    }
  }

  List<int> decodeBinary() {
    // TODO:
    //CryptoUtils.base64StringToBytes(
    return null;
  }
}
