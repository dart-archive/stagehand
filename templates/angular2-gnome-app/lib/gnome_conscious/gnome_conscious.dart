library gnome_conscious;

// Copyright (c) {{year}}, {{author}}. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:gnome_tutorial/gnome_pics/gnome_pics.dart';

@Component(
    selector: 'gnome-conscious',
    // NOTE: events cannot contain upper case; the html listeners will simply fail to respond
    events: const ['awoke', 'slept']
    )
@View(
    template: '''
      <!-- pass the result of an expression into GnomePics -->
      <gnome-pics [is-sleeping]="isSleeping"></gnome-pics>

      <p>

      <!-- show/hide elements based on state, react to native DOM events -->
      Change the gnome's state:
      <button *ng-if="!isSleeping" (click)="sleep()">Sleep</button>
      <button *ng-if="isSleeping" (click)="wake()">Wake</button>
    ''',
    directives: const [GnomePics, NgIf]
    )
class GnomeConscious {
  bool isSleeping = false;
  EventEmitter awoke;
  EventEmitter slept;

  GnomeConscious() {
    awoke = new EventEmitter();
    slept = new EventEmitter();
  }

  void sleep() {
    isSleeping = true;
    // when just triggering a listener, sending null works, or could send a value
    slept.add(null);
  }

  void wake() {
    isSleeping = false;
    // if you need to set cancelable or bubbling, you can send an event
    awoke.add(new Event('awoke'));
  }

  // uses async* to generate a Stream of "z"
  Stream<String> snoring(zCount) async* {
    int i = 0;
    while (i < zCount) {
      i++;
      yield "z";
    }
  }
}
