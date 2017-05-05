// Copyright (c) __year__, __author__. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:angular_components/angular_components.dart';

import '../cheer_dialog/cheer_dialog.dart';

@Component(
  selector: 'hall-of-fame',
  templateUrl: 'hall_of_fame_component.html',
  directives: const [materialDirectives, CheerDialog],
)
class HallOfFameComponent {
  @Input()
  List<String> heroes = [];
}
