@Tags(const ['aot'])
@TestOn('browser')

import 'package:angular2/angular2.dart';
import 'package:angular_test/angular_test.dart';
import 'package:test/test.dart';

import 'package:__projectName__/app_component.dart';
import 'app_po.dart';

NgTestFixture<AppComponent> fixture;
AppPO appPO;

@AngularEntrypoint()
void main() {
  final testBed = new NgTestBed<AppComponent>();

  setUp(() async {
    fixture = await testBed.create();
    appPO = await fixture.resolvePageObject(AppPO);
  });

  tearDown(disposeAnyRunningTest);

  test('title', () async {
    expect(await appPO.title, 'My First AngularDart App');
  });

  test('no greeting by default', () async {
    expect(await appPO.greeting, null);
  });

  group('tabs:', () {
    final tabNames = <String>['Greeting', 'Hall of Fame'];

    test('names', () async {
      expect(await appPO.tabNames, tabNames);
    });

    test('active', () async {
      expect(await appPO.activeTabName, tabNames[0]);
    });
  });

  group('Greet:', () {
    testGreeting('mysterious stranger', '');
    testGreeting('Alice');
    testGreeting('Bob');
  });
}

void testGreeting(String expectName, [String whatToType]) {
  test(expectName, () async {
    await appPO.type(whatToType ?? expectName);
    await appPO.sayHello();
    // Rebind to get optional greeting.
    appPO = await fixture.resolvePageObject(AppPO);
    expect(await appPO.greeting, 'Hello, $expectName!');
  });
}
