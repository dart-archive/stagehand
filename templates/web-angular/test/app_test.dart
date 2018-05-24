@TestOn('browser')
import 'package:angular_test/angular_test.dart';
import 'package:test/test.dart';
import 'package:__projectName__/app_component.dart';
import 'package:__projectName__/app_component.template.dart' as ng;
import 'package:pageloader/html.dart';

import 'app_po.dart';

void main() {
  final testBed =
      NgTestBed.forComponent<AppComponent>(ng.AppComponentNgFactory);
  NgTestFixture<AppComponent> fixture;
  AppPO appPO;

  setUp(() async {
    fixture = await testBed.create();
    final context =
        new HtmlPageLoaderElement.createFromElement(fixture.rootElement);
    appPO = new AppPO.create(context);
  });

  tearDown(disposeAnyRunningTest);

  test('heading', () {
    expect(appPO.title, contains('My First AngularDart App'));
  });
}
