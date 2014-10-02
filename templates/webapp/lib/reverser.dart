// Copyright (c) {{year}}, <your name>. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library reverser;

import 'dart:html';

// Example of hooking into the DOM and responding to changes from input fields
initReverser() {
  var output = querySelector('#out');
  var input = querySelector('#name');
  input.onKeyUp.listen((_) {
    output.text = input.value.split('').reversed.join();
  });
}
