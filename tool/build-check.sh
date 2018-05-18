#!/bin/bash
#
# Ensure that "pub run build_runner build" was run and committed.
#
# Copyright (c) 2017, Google Inc. Please see the AUTHORS file for details.
# All rights reserved. Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# Fast fail the script on failures.
set -x -e -o pipefail

pub run build_runner build --delete-conflicting-outputs
git status
git add .
git diff-index --quiet HEAD
