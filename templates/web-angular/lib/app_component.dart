// Copyright (c) __year__, __author__. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:angular_components/angular_components.dart';

import 'hall_of_fame/hall_of_fame_component.dart';

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [materialDirectives, HallOfFameComponent],
  providers: const [materialProviders],
)
class AppComponent {
  String name = '';
  List<String> heroes = buildNames().toList();

  void greet(String whoToGreet) {
    name = whoToGreet.isEmpty ? 'mysterious stranger' : whoToGreet;
  }
}

Iterable<String> buildNames() sync* {
  // Suggested function body
  // (see https://webdev.dartlang.org/guides/get-started for details):
  /*
    var prefixes = ['Super', 'Mega', 'Ultra'];
    var suffixes = ['man', 'woman', 'boy', 'girl'];

    for (var prefix in prefixes) {
      for (var suffix in suffixes) {
        yield '$prefix$suffix';
      }
    }
   */
}
