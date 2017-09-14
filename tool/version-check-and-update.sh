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

CLIFILE=lib/src/cli_app.dart
if grep -qe "APP_VERSION = '$VERS_FROM_PUB';" $CLIFILE; then
  echo "✔ $CLIFILE has same version as pubspec."
else
  EXIT_CODE=2
  perl -i -pe "s/(APP_VERSION = ')[^']*(';)/APP_VERSION = '$VERS_FROM_PUB';/" $CLIFILE
  echo "⚠ $CLIFILE: HAS BEEN MODIFIED to use pubspec app version."
fi

CHANGELOG=CHANGELOG.md
VERS_WO_DEV=${VERS_FROM_PUB/%-dev/}

if grep -qe "^##\s*${VERS_WO_DEV//./\\.}\s*" $CHANGELOG; then
  echo "✔ $CHANGELOG has entry for $VERS_WO_DEV"
else
  EXIT_CODE=1
  echo "❌ $CHANGELOG: Can't find entry for $VERS_WO_DEV"
fi

exit $EXIT_CODE
