import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';

import 'packages/{{projectName}}/main_app.dart';

void main() {
  applicationFactory().rootContextType(MainApp).run();
}