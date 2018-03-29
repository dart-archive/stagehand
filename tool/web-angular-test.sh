#!/bin/bash

# Copyright (c) 2017, Google Inc. Please see the AUTHORS file for details.
# All rights reserved. Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# Fast fail the script on failures.
set -e -o pipefail

source ./tool/env-set.sh

# Run component tests for web-angular.
pushd templates/web-angular
travis_fold start web_angular.pub
  (set -x; pub get)
travis_fold end web_angular.pub
travis_fold start web_angular.test
  (set -x; pub run build_runner test --fail-on-severe -- -p chrome --reporter=expanded)
travis_fold end web_angular.test
popd
