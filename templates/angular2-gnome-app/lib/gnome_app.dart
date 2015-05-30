library gnome_app;

// Copyright (c) {{year}}, {{author}}. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';
import 'package:gnome_tutorial/gnome_conscious/gnome_conscious.dart';
import 'package:gnome_tutorial/math/math.dart';

@Component(
    selector: 'gnome-app'
    )
@View(
    template: '''
      <!-- react to custom events -->
      <gnome-conscious (awoke)="showFriends()" (slept)="hideFriends()"></gnome-conscious>

      <p/>

      <!--conditionally display a variable-->
      <b *ng-if="isShowFriends">The gnome is awake, let's have a party with {{count}} guests!</b>
    ''',
    directives: const [GnomeConscious, NgIf]
    )
class GnomeApp {
  bool isShowFriends = true;
  int count = 2;

  bumpGuestCount() => count += Math.doubleIt(count);

  void showFriends() {
    isShowFriends = true;
    bumpGuestCount();
  }

  void hideFriends() {
    isShowFriends = false;
  }
}