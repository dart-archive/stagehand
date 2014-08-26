//  Copyright (c) 2014, Google.
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

import 'package:args/args.dart';
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

  String _generatorName;
  String _outputDir;
  
  CliApp(this.generators, this.logger, [this.target]) {
    assert(generators != null);
    assert(logger != null);
    
    generators.sort(Generator.compareGenerators);
  }

  ArgParser _extractArgs(List<String> args) {
    var argParser = new ArgParser();

    argParser.addOption('outdir', abbr: 'o', valueHelp: 'path', help: 'Where to put the files.');
    argParser.addFlag('help', abbr: 'h', negatable: false);

    try {
      var options = argParser.parse(args);
      if (options['help']) {
        _usage(argParser);
        io.exit(0);
      }
      if (options.rest == null || options.rest.isEmpty) {
        throw new ArgumentError('No generator specified');
      }
      _generatorName = options.rest.first;
      _outputDir = options['outdir'];
      if (_outputDir == null) {
        throw new ArgumentError('No output directory specified');
      }
    } catch(e) {
      print('$e\n');
      _usage(argParser);
      io.exit(1);
    }

    return argParser;
  }

  void _usage(ArgParser argParser) {
    _out('usage: ${APP_NAME} -o <output directory> generator-name');
    _out(argParser.getUsage());
    _out('');
    _out('generators\n----------');
    int len = generators
    .map((g) => g.id.length)
    .fold(0, (a, b) => max(a, b));
    generators
    .map((g) => "[${_pad(g.id, len)}] ${g.description}")
    .forEach(logger.stdout);
  }
  
  Future process(List<String> args) {
    var argParser = _extractArgs(args);

    Generator generator = _getGenerator(_generatorName);
    
    if (generator == null) {
      logger.stderr("'${_generatorName}' is not a valid generator.\n");
      _usage(argParser);
      return new Future.error('invalid generator');
    }
    
    io.Directory dir = new io.Directory(_outputDir);
    String projectName = path.basename(dir.path);
    
    if (dir.existsSync()) {
      logger.stderr("Error: '${dir.path}' already exists.\n");
      return new Future.error('target path already exists');
    }
    
    // TODO: validate name (no spaces)
    
    if (target == null) {
      target = new DirectoryGeneratorTarget(logger, dir);
    }
    
    _out("Creating ${_generatorName} application '${projectName}':");
    return generator.generate(projectName, target).then((_) {
      _out("${generator.numFiles()} files written.");
    });
  }
  
  Generator _getGenerator(String id) {
    return generators.firstWhere((g) => g.id == id, orElse: () => null);
  }
  
  void _out(String str) => logger.stdout(str);

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
