// Copyright (c) {{year}}, <your name>. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:html';

void main() {
  var element = new DivElement()
    ..text = "Hello, World!";
  document.body.children.add(element);
}
