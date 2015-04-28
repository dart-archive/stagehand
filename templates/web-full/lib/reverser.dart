// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library reverser;

import 'dart:html';

InputElement get _inputElement => querySelector('#name');
Element get _outputElement => querySelector('#out');

// Example of hooking into the DOM and responding to changes from input fields.
initReverser() {
  // Reverse on startup.
  _reverse();

  // Reverse on each key stroke.
  _inputElement.onKeyUp.listen((_) => _reverse());
}

_reverse() {
  _outputElement.text = _inputElement.value.split('').reversed.join();
}
