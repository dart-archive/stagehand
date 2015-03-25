// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:chrome/chrome_app.dart' as chrome;

import 'package:polymer/polymer.dart';

@CustomTag('main-app')
class MainApp extends PolymerElement {
	int _boundsChange = 100;


	/// Constructor used to create instance of MainApp.
  MainApp.created() : super.created();

  void resizeWindow() {
	  chrome.ContentBounds bounds = chrome.app.window.current().getBounds();

	  bounds.width += this._boundsChange;
	  bounds.left -= this._boundsChange ~/ 2;

	  chrome.app.window.current().setBounds(bounds);

	  this._boundsChange *= -1;
  }
}
