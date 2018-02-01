#!/bin/bash

# Copyright (c) 2014, Google Inc. Please see the AUTHORS file for details.
# All rights reserved. Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# Fast fail the script on failures.
set -e

source ./tool/env-set.sh

# Verify that the libraries are error free.
dartanalyzer --fatal-warnings \
  bin/stagehand.dart \
  lib/stagehand.dart \
  test/all.dart

echo
echo Running dartfmt over templates.
REFORMATTED_FILES=$(dartfmt -n templates)
if [[ -n $REFORMATTED_FILES ]]; then
  echo "Aborting. Format these files and try again:"
  echo "$REFORMATTED_FILES"
  exit 1;
fi

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
