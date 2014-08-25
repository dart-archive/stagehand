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
