#!/bin/bash

# Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
# All rights reserved. Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# Fast fail the script on failures.
set -e

if [ ! $(type -t travis_fold) ]; then
    travis_fold () { echo "travis_fold:${1}:${2}"; }
    # In case this is being run locally. Turn travis_fold into a noop.
    # travis_fold () { true; }
fi
export -f travis_fold

# Verify that the libraries are error free.
dartanalyzer --fatal-warnings \
  bin/stagehand.dart \
  lib/stagehand.dart \
  test/all.dart

# Run the tests.
travis_fold start test_all
dart test/all.dart
travis_fold end test_all

# Run all the generators and analyze the generated code.
travis_fold start validate_templates
pub run test test/validate_templates.dart
travis_fold end validate_templates

# Install dart_coveralls; gather and send coverage data.
if [ "$COVERALLS_TOKEN" ]; then
  travis_fold start dart_coveralls
  pub global activate dart_coveralls
  pub global run dart_coveralls report \
    --token $COVERALLS_TOKEN \
    --retry 2 \
    --exclude-test-files \
    test/all.dart
  travis_fold end dart_coveralls
fi

# Run component tests for web-angular.
pushd templates/web-angular
travis_fold start web_angular.pub
  (set -x; pub get)
travis_fold end web_angular.pub
travis_fold start web_angular.test
  (set -x; pub run angular_test)
travis_fold end web_angular.test
popd
