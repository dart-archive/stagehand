# Display installed versions.
dart --version

# Get our packages.
pub get

# Verify that the libraries are error free.
dartanalyzer --fatal-warnings bin/stagehand.dart test/all.dart

# Run the tests.
dart test/all.dart
