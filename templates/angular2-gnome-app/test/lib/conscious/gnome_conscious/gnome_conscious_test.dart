@TestOn("browser") // only run this test in a browser, otherwise ignore it
@Timeout(const Duration(seconds: 2)) // timeout async tests after only two seconds rather than the 30sec default

// Copyright (c) {{year}}, {{author}}. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:test/test.dart';
import 'package:gnome_tutorial/gnome_conscious/gnome_conscious.dart';

main() {
  var gnomeConscious;

  setUp(() {
    gnomeConscious = new GnomeConscious();
  });

  group('test of the model, no need for a browser', () {

    // test model updates
    test('wake should set isSleeping false', () {
      gnomeConscious.wake();
      expect(gnomeConscious.isSleeping, equals(false));
    });

    test('sleep should set isSleeping true', () {
      gnomeConscious.sleep();
      expect(gnomeConscious.isSleeping, equals(true));
    });
  });

  group('test the component events using expectAsync, needs a browser', () {

    // use expectAsync to test that events are emitted by the component
    test('wake should emit an "awoke" Event', () {
      gnomeConscious.awoke.listen(expectAsync((event) {
        expect(event.type, equals('awoke'));
      }, count: 1));

      gnomeConscious.wake();
    });

    test('sleep should emit a null event on the "slept" Stream', () {
      gnomeConscious.slept.listen(expectAsync((event) {
        expect(event, equals(null));
      }, count: 1));

      gnomeConscious.sleep();
    });
  });

  group('test asynchronous events using async/await', () {

    // uses async/await to test asynchronous events
    test('snore() should return multiple z', () async {
      Stream snore = gnomeConscious.snoring(6);
      var concat = await snore.join();
      expect(concat, equals("zzzzzz"));
    });
  });
}
