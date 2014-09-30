// Copyright (c) {{year}}, <your name>. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:polymer/polymer.dart';
import 'dart:html';

/**
 * A Polymer hello-world element.
 */
@CustomTag('main-app')

class MainApp extends PolymerElement {

  @observable String input = '';
  @observable String reversed = '';

  /// Constructor used to create instance of MainApp.
  MainApp.created() : super.created();

  void inputChanged(String oldValue, String newValue) {
    reversed = input.split('').reversed.join('');
  }

  /*
   * Optional lifecycle methods - uncomment if needed.
   *

  /// Called when an instance of hello-world is inserted into the DOM.
  attached() {
    super.attached();
  }

  /// Called when an instance of hello-world is removed from the DOM.
  detached() {
    super.detached();
  }

  /// Called when an attribute (such as  a class) of an instance of
  /// hello-world is added, changed, or removed.
  attributeChanged(String name, String oldValue, String newValue) {
    super.attributeChanges(name, oldValue, newValue);
  }

  /// Called when hello-world has been fully prepared (Shadow DOM created,
  /// property observers set up, event listeners attached).
  ready() {
    super.ready();
  }
   
  */
  
}
