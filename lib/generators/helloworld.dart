
library stagehand.helloworld;

import '../src/common.dart';
import '../stagehand.dart';

/**
 * TODO:
 */
class HelloWorldGenerator extends Generator {
  HelloWorldGenerator() : super(
      'helloworld', 
      "A simple hello world command-line application.",
      categories: const ['dart', 'helloworld']) {
    
    // .gitignore and pubspec.yaml.    
    add(_gitignore);
    add(_pubspec);
    
    // The bin/ directory.
    TemplateDirectory bin = add(new TemplateDirectory('bin'));
    setEntrypoint(bin.add(_helloworld));
  }
  
  TemplateFile get _pubspec => new TemplateFile('pubspec.yaml', '''
name: {{projectName}}
version: 0.0.1
description: ${description}
''');

  TemplateFile get _helloworld => new TemplateFile('helloworld.dart', '''
main() {
  print('Hello world!');
}
''');

  TemplateFile get _gitignore => new TemplateFile('.gitignore', gitIgnoreContents);
}
