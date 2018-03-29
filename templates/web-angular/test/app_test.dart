@TestOn('browser')
import 'dart:async';

import 'package:angular_test/angular_test.dart';
import 'package:pageloader/objects.dart';
import 'package:test/test.dart';
import 'package:__projectName__/app_component.dart';

import 'app_test.template.dart' as ng;

NgTestFixture<AppComponent> fixture;
AppPO appPO;

void main() {
  ng.initReflector();
  final testBed = new NgTestBed<AppComponent>();

  setUp(() async {
    fixture = await testBed.create();
    // TODO: temporary. https://github.com/dart-lang/site-webdev/issues/1351
    appPO = await new AppPO().resolve(fixture);
    // appPO = await fixture.resolvePageObject(AppPO);
  });

  tearDown(disposeAnyRunningTest);

  test('title', () async {
    expect(await appPO.title, 'My First AngularDart App');
  });

  // Testing info: https://webdev.dartlang.org/angular/guide/testing
}

class AppPO
    // TODO: temporary. https://github.com/dart-lang/site-webdev/issues/1351
    extends PageObjectBase //
{
  @ByTagName('h1')
  PageLoaderElement get _title => q('h1');

  Future<String> get title => _title.visibleText;
}
