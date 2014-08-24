
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
        
    _addFile('.gitignore', gitIgnoreContents);
    _addFile('pubspec.yaml', _pubspec);
    var f = _addFile('web/main.dart', _main);
    
    setEntrypoint(f);
  }
  
  String get _pubspec => '''
name: {{projectName}}
version: 0.0.1
description: ${description}
dependencies:
  browser: any
''';

  String get _main => '''
main() {
  print('Hello world!');
}
''';

  TemplateFile _addFile(String path, String contents) =>
      addFile(new TemplateFile(path, contents));
}
