
library stagehand.cli;

import 'dart:async';
import 'dart:io' as io;
import 'dart:math';

import 'package:path/path.dart' as path;
import 'package:stagehand/stagehand.dart';

const String APP_NAME = 'stagehand';

void main(List<String> args) {
  CliApp app = new CliApp(generators);
  app.process(args).catchError((e) {
    // TODO: print e
    io.exit(1);
  });
}

class CliApp {
  final List<Generator> generators;
  
  CliController controller;
  GeneratorTarget generatorTarget;
  
  CliApp(this.generators, [this.controller, this.generatorTarget]) {
    assert(generators != null);
    
    generators.sort(Generator.compareGenerators);
    
    if (controller == null) {
      controller = new CliController();
    }
  }
  
  Future process(List<String> args) {
    if (args.length == 0) {
      _usage(controller);
      return new Future.value();
    } else if (args.length > 2) {
      controller.error("Too many parameters given.\n");
      _usage(controller);
      return new Future.error('too many paramaters');
    }
    
    String id = args.first;
    Generator generator = _getGenerator(id);
    
    if (generator == null) {
      controller.error("'${id}' is not a valid generator.\n");
      _usage(controller);
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
      controller.error("Error: '${dir.path}' already exists.\n");
      return new Future.error('target path already exists');
    }
    
    // TODO: validate name (no spaces)
    
    if (generatorTarget == null) {
      generatorTarget = new DirectoryGeneratorTarget(controller, dir);
    }
    
    _out("Creating ${id} application '${projectName}':");
    return generator.generate(projectName, generatorTarget).then((_) {
      _out("${generator.numFiles()} files written.");
    });
  }
  
  Generator _getGenerator(String id) {
    return generators.firstWhere((g) => g.id == id, orElse: () => null);
  }
  
  void _out(String str) => controller.stdout(str);
  
  void _usage(CliController controller) {
    _out('usage: ${APP_NAME} <generator> <output directory>');
    _out('');
    _out('generators\n----------');
    int len = generators
      .map((g) => g.id.length)
      .fold(0, (a, b) => max(a, b));
    generators
      .map((g) => "[${_pad(g.id, len)}] ${g.description}")
      .forEach(controller.stdout);
  }
}

class CliController {
  void error(String message) => print(message);
  void stdout(String message) => print(message);
}

class DirectoryGeneratorTarget extends GeneratorTarget {
  final CliController controller;
  final io.Directory dir;
  
  DirectoryGeneratorTarget(this.controller, this.dir) {
    dir.createSync();
  }
  
  Future createFile(String filePath, List<int> contents) {
    io.File file = new io.File(path.join(dir.path, filePath));
    
    controller.stdout('  ${file.path}');
    
    return file
      .create(recursive: true)
      .then((_) => file.writeAsBytes(contents));
  }
}

String _pad(String str, int len) {
  while (str.length < len) str += ' ';
  return str;
}
