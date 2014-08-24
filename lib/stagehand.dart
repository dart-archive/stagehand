
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
  
  final TemplateDirectory root;
  TemplateFile _entrypoint;
  
  Generator(this.id, this.description, {this.categories: const []}) :
      root = new TemplateDirectory('');
  
  /** 
   * The entrypoint of the application; the main file for the project, which an
   * IDE might open after creating the project.
   */
  TemplateFile get entrypoint => _entrypoint;
  
  /**
   * TODO:
   */
  TemplateEntry add(TemplateEntry entry) {
    root.add(entry);
    return entry;
  }
  
  void setEntrypoint(TemplateFile entrypoint) {
    assert(this._entrypoint == null);
    this._entrypoint = entrypoint;
  }
  
  Future generate(String directoryName, GeneratorTarget target) {
    Map vars = {'projectName': directoryName};
    
    return _generate(target, root, vars);
  }
  
  int fileCount() => root.fileCount();
  
  String toString() => '[${id}: ${description}]';
  
  Future _generate(GeneratorTarget target, TemplateEntry entry, Map vars) {
    if (entry is TemplateFile) {
      return target.createFile(entry.path, entry.createContent(vars));
    } else {
      return Future.forEach((entry as TemplateDirectory).children, (child) {
        return _generate(target, child, vars);
      });
    }
  }
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
 * An abstract superclass of [TemplateFile] and [TemplateDirectory].
 */
abstract class TemplateEntry {
  static int _compare(TemplateEntry a, TemplateEntry b) {
    if (a is TemplateFile && b is! TemplateFile) return -1;
    if (a is! TemplateFile && b is TemplateFile) return 1;
    return a.name.toLowerCase().compareTo(b.name.toLowerCase());
  }
  
  /// The name of the entry.
  final String name;
  
  /// The optional parent of the entry.
  TemplateDirectory parent;
  
  TemplateEntry(this.name);
  
  /// The full path of the entry from the root node.
  String get path => parent.isRoot ? name : '${parent.path}/${name}';
  
  /// The total file count for this entry and all sub-directories.
  int fileCount();
}

/**
 * This class represents a file in a generator template. The contents could 
 * either be binary or text. If text, the contents may contain mustache 
 * variables that can be substituted (`{{myVar}}`).
 */
class TemplateFile extends TemplateEntry {
  final String content;
  final bool isBinary;
  
  TemplateFile(String name, this.content, [this.isBinary = false]) :
      super(name);

  int fileCount() => 1;

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

/**
 * This class represents a directory in a generator template.
 */
class TemplateDirectory extends TemplateEntry {
  final List<TemplateEntry> children = [];
  
  TemplateDirectory(String name) : super(name);
  
  TemplateEntry add(TemplateEntry entry) {
    children.add(entry);
    entry.parent = this;
    children.sort(TemplateEntry._compare);
    return entry;
  }
  
  bool get isRoot => parent == null;
  
  String get path => isRoot ? '' : super.path;

  int fileCount() {
    return children
      .map((child) => child.fileCount())
      .fold(0, (a, b) => a + b);
  }
}
