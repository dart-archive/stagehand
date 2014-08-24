
/**
 * TODO:
 */
library stagehand.utils;

String gitIgnoreContents = '''
.DS_Store
packages
pubspec.lock
''';

/**
 * TODO:
 */
String substituteVars(String str, Map vars) {
  vars.forEach((key, value) {
    String sub = '{{${key}}}';
    str = str.replaceAll(sub, value);
  });
  return str;
}
