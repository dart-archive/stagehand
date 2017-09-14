# This bash file is meant to be source'd, not executed.

# Copyright (c) 2017, Google Inc. Please see the AUTHORS file for details.
# All rights reserved. Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

if [ ! $(type -t travis_fold) ]; then
    travis_fold () { echo "travis_fold:${1}:${2}"; }
    # In case this is being run locally. Turn travis_fold into a noop.
    # travis_fold () { true; }
fi
export -f travis_fold
