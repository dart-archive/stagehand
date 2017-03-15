// Copyright (c) __year__, __author__. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';
import 'package:stagexl/stagexl.dart';

Future<Null> main() async {

  StageOptions options = new StageOptions()
    ..backgroundColor = Color.White
    ..renderEngine = RenderEngine.WebGL;

  var canvas = querySelector('#stage');
  var stage = new Stage(canvas, width: 1280, height: 800, options: options);

  var renderLoop = new RenderLoop();
  renderLoop.addStage(stage);

  var resourceManager = new ResourceManager();
  resourceManager.addBitmapData("dart", "images/dart@1x.png");

  await resourceManager.load();

  var logoData = resourceManager.getBitmapData("dart");
  var logo = new Bitmap(logoData);

  logo.pivotX = logoData.width / 2;
  logo.pivotY = logoData.height / 2;

  // place it on top-center
  logo.x = 1280 / 2;
  logo.y = 0;

  stage.addChild(logo);

  // ... and let it fall
  var tween = stage.juggler.addTween(logo, 3, Transition.easeOutBounce);
  tween.animate.y.to(800 / 2);

  // see more examples:
  // https://github.com/bp74/StageXL_Samples

}
