// Copyright (c) {{year}}, {{author}}. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'package:appengine/appengine.dart';

requestHandler(HttpRequest request) {
  request.response
  ..write('Helloo!')
  ..close();
}

main() {
  runAppEngine(requestHandler);
}
