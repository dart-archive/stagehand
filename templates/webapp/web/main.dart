// Copyright (c) {{year}}, {{author}}. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'package:{{projectName}}/nav_menu.dart';
import 'package:{{projectName}}/reverser.dart';
import 'package:route_hierarchical/client.dart';

void main() {
  initNavMenu();
  initReverser();

  // Webapps need routing to listen for changes to the URL

  var router = new Router();
  router.root
    ..addRoute(name: 'about', path: '/about', enter: showAbout)
    ..addRoute(name: 'home', defaultRoute: true, path: '/', enter: showHome);
  router.listen();
}

void showAbout(RouteEvent e) {
  // Extremely simple and non-scalable way to show different views
  querySelector('#home').style.display = 'none';
  querySelector('#about').style.display = '';
}

void showHome(RouteEvent e) {
  querySelector('#home').style.display = '';
  querySelector('#about').style.display = 'none';
}
