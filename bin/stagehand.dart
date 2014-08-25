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
library stagehand.cli;

import 'dart:async';
import 'dart:io' as io;
import 'dart:math';

import 'package:path/path.dart' as path;
import 'package:stagehand/stagehand.dart';

const String APP_NAME = 'stagehand';

void main(List<String> args) {
  CliApp app = new CliApp(generators, new CliLogger());
  app.process(args).catchError((e) {
    io.exit(1);
  });
}

class CliApp {
  final List<Generator> generators;
  final CliLogger logger;
  GeneratorTarget target;
  
  CliApp(this.generators, this.logger, [this.target]) {
    assert(generators != null);
    assert(logger != null);
    
    generators.sort(Generator.compareGenerators);
  }
  
  Future process(List<String> args) {
    if (args.length == 0) {
      _usage();
      return new Future.value();
    } else if (args.length > 2) {
      logger.stderr("Too many parameters given.\n");
      _usage();
      return new Future.error('too many paramaters');
    }
    
    String id = args.first;
    Generator generator = _getGenerator(id);
    
    if (generator == null) {
      logger.stderr("'${id}' is not a valid generator.\n");
      _usage();
      return new Future.error('invalid generator');
    }

    if (args.length == 1) {
      _out("[${generator.id}] ${generator.description}\n");
      _out("Create using: ${APP_NAME} ${generator.id} <output directory>");
      return new Future.value();
    }
    
    io.Directory dir = new io.Directory(args[1]);
    String projectName = path.basename(dir.path);
    
    if (dir.existsSync()) {
      logger.stderr("Error: '${dir.path}' already exists.\n");
      return new Future.error('target path already exists');
    }
    
    // TODO: validate name (no spaces)
    
    if (target == null) {
      target = new DirectoryGeneratorTarget(logger, dir);
    }
    
    _out("Creating ${id} application '${projectName}':");
    return generator.generate(projectName, target).then((_) {
      _out("${generator.numFiles()} files written.");
    });
  }
  
  Generator _getGenerator(String id) {
    return generators.firstWhere((g) => g.id == id, orElse: () => null);
  }
  
  void _out(String str) => logger.stdout(str);
  
  void _usage() {
    _out('usage: ${APP_NAME} <generator> <output directory>');
    _out('');
    _out('generators\n----------');
    int len = generators
      .map((g) => g.id.length)
      .fold(0, (a, b) => max(a, b));
    generators
      .map((g) => "[${_pad(g.id, len)}] ${g.description}")
      .forEach(logger.stdout);
  }
}

class CliLogger {
  void stdout(String message) => print(message);
  void stderr(String message) => print(message);
}

class DirectoryGeneratorTarget extends GeneratorTarget {
  final CliLogger logger;
  final io.Directory dir;
  
  DirectoryGeneratorTarget(this.logger, this.dir) {
    dir.createSync();
  }
  
  Future createFile(String filePath, List<int> contents) {
    io.File file = new io.File(path.join(dir.path, filePath));
    
    logger.stdout('  ${file.path}');
    
    return file
      .create(recursive: true)
      .then((_) => file.writeAsBytes(contents));
  }
}

String _pad(String str, int len) {
  while (str.length < len) str += ' ';
  return str;
}
