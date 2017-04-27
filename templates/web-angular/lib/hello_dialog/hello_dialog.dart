// Copyright (c) __year__, __author__. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:angular_components/angular_components.dart';

@Component(
  selector: 'hello-dialog',
  styleUrls: const ['hello_dialog.css'],
  templateUrl: 'hello_dialog.html',
  directives: const [materialDirectives],
  providers: const [materialProviders],
)
class HelloDialog {
  /// Modal component that hosts the inner MaterialDialog in a centered overlay.
  @ViewChild('wrappingModal')
  ModalComponent wrappingModal;

  /// Name of user.
  @Input()
  String name = "";

  /// Opens the dialog.
  void open([String name]) {
    if (name != null) this.name = name;
    wrappingModal.open();
  }
}
