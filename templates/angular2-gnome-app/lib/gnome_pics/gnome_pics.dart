library gnome_pics;

// Copyright (c) {{year}}, {{author}}. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';

@Component(
    selector: 'gnome-pics',
    properties: const {'isSleeping': 'is-sleeping'}
    )
@View(
    template: '''
      <img *ng-if="!isSleeping" src="images/happy_gnome.jpeg"/>
      <img *ng-if="isSleeping" src="images/sleepy_gnome.jpeg"/>
    ''',
    directives: const [NgIf]
    )
class GnomePics {
  bool isSleeping = false;
}