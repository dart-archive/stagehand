@Tags(const ['aot'])
@TestOn('browser')

import 'package:angular2/angular2.dart';
import 'package:angular_test/angular_test.dart';
import 'package:test/test.dart';

import 'package:__projectName__/app_component.dart';

@AngularEntrypoint()
void main() {
  final testBed = new NgTestBed<AppComponent>();
  NgTestFixture<AppComponent> fixture;

  setUp(() async {
    fixture = await testBed.create();
  });

  tearDown(disposeAnyRunningTest);

  test('Default greeting', () {
    expect(fixture.text, 'Hello Angular');
  });

  test('Greet world', () async {
    await fixture.update((c) => c.name = 'World');
    expect(fixture.text, 'Hello World');
  });

  test('Greet world HTML', () {
    final html = fixture.rootElement.innerHtml;
    expect(html, '<h1>Hello Angular</h1>');
  });
}
