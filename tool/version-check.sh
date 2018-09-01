#!/bin/bash
#
# Ensure that all relevant files have consistent app version numbers.
#
# Copyright (c) 2017, Google Inc. Please see the AUTHORS file for details.
# All rights reserved. Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# Fast fail the script on failures.
set -e -o pipefail

EXIT_CODE=0

VERS_FROM_PUB=$(grep '^version:' pubspec.yaml | awk '{ print $2 }')

echo "Version of stagehand from pubspec.yaml: $VERS_FROM_PUB"

VERSION_FILE=lib/src/version.dart
if grep -qe "packageVersion = '$VERS_FROM_PUB';" $VERSION_FILE; then
  echo "✔ $VERSION_FILE has same version as pubspec."
else
  EXIT_CODE=2
  echo "⚠️ $VERSION_FILE: is outdated. Run 'pub run build_runner build'"
fi

CHANGELOG=CHANGELOG.md
VERS_WO_DEV=${VERS_FROM_PUB/%-dev/}

if grep -Eqe "^##\s*${VERS_WO_DEV//./\\.}(-dev)?(\s+|$)" $CHANGELOG; then
  echo "✔ $CHANGELOG has entry for $VERS_WO_DEV (or $VERS_WO_DEV-dev)"
else
  EXIT_CODE=1
  echo "❌ $CHANGELOG: Can't find entry for $VERS_WO_DEV (or $VERS_WO_DEV-dev)"
fi

exit $EXIT_CODE
