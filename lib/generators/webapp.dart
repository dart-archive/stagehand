
library stagehand.webapp;

import '../src/common.dart';
import '../stagehand.dart';

/**
 * TODO:
 */
class WebAppGenerator extends Generator {
  WebAppGenerator() : super(
      'webapp', 
      "This is the most minimal option for the developer that doesn’t want to "
      "be confused by too much going on.",
      categories: const ['dart', 'web']) {
        
    // .gitignore and pubspec.yaml.
    add(_gitignore);
    add(_pubspec);
    
    // TODO: index.html, css
    // The web/ directory.
    TemplateDirectory web = add(new TemplateDirectory('web'));
    setEntrypoint(web.add(_main));
  }
  
  TemplateFile get _pubspec => new TemplateFile('pubspec.yaml', '''
name: {{projectName}}
version: 0.0.1
description: ${description}
dependencies:
  browser: any
''');

  TemplateFile get _main => new TemplateFile('main.dart', '''
main() {
  print('Hello world!');
}
''');

  TemplateFile get _gitignore => new TemplateFile('.gitignore', gitIgnoreContents);
}
