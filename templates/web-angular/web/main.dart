import 'package:angular/angular.dart';
import 'package:__projectName__/app_component.dart';

import 'main.template.dart' as ng;

void main() {
  bootstrapStatic(AppComponent, [], ng.initReflector);
}
