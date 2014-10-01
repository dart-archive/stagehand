// Copyright (c) {{year}}, <your name>. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:html';

void main() {
  // something about grabbing the input and doing something with it
  var output = querySelector('#out');
  var input = querySelector('#name');
  input.onKeyUp.listen((_) {
    output.text = input.value.split('').reversed.join();
  });
}
