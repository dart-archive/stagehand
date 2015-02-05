# This script initialized the stagehandData directory
# this script should be run before using stagehand

mkdir ~/stagehandData
cd extensiondata
cp isloader.dart.data ~/stagehandData/isloader.dart
cp pubspec.yaml.data ~/stagehandData/pubspec.yaml
cd ~/stagehandData
pub get
