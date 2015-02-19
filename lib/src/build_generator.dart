// Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
/**
 * Return a generator from plugin. This will read pluginData map to extract the information required to build the generator.
 */
library stagehand.build_generator;

import 'package:stagehand/src/common.dart';
import 'package:stagehand/stagehand.dart';
class PluginGenerator extends DefaultGenerator {
  String help = "";
  PluginGenerator(var name, Map pluginData) : super(
      name,
      pluginData['info'],
      pluginData['description'],
      //TODO: Read this from pluginData
      categories: const ['dart', 'web']) {
    for (TemplateFile file in decodeConcanenatedData(pluginData['data'])) {
      addTemplateFile(file);
    }
    setEntrypoint(getFile(pluginData['entrypoint']));
    help = pluginData['help'];
  }

  String getInstallInstructions() =>
  "${super.getInstallInstructions()}\n"
  + help;
}