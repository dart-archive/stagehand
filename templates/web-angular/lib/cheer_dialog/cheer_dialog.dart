// Copyright (c) __year__, __author__. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular_components/angular_components.dart';

@Component(
  selector: 'cheer-dialog',
  styleUrls: const ['cheer_dialog.css'],
  templateUrl: 'cheer_dialog.html',
  directives: const [materialDirectives],
)
class CheerDialog {
  /// Modal component that hosts the inner MaterialDialog in a centered overlay.
  @ViewChild('wrappingModal')
  ModalComponent wrappingModal;

  /// Name of user.
  String name = '';

  void open(String name) {
    this.name = name;
    wrappingModal.open();
  }

  Future<bool> close() => wrappingModal.close();
}
