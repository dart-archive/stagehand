library gnome_app;

import 'package:angular2/angular2.dart';
import 'package:{{projectName}}/gnome_conscious/gnome_conscious.dart';
import 'package:{{projectName}}/math/math.dart';

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