#!/bin/bash

# Copyright (c) 2017, Google Inc. Please see the AUTHORS file for details.
# All rights reserved. Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# Fast fail the script on failures.
set -e -o pipefail

source ./tool/env-set.sh

# Run component tests for web-angular.
pushd templates/web-angular

sh -e /etc/init.d/xvfb start
t=0; until (xdpyinfo -display :99 &> /dev/null || test $t -gt 10); do sleep 1; let t=$t+1; done

travis_fold start web_angular.pub
  (set -x; pub get)
travis_fold end web_angular.pub
travis_fold start web_angular.test
  (set -x; pub run build_runner test --fail-on-severe -- -p chrome --reporter=expanded)
travis_fold end web_angular.test
popd
