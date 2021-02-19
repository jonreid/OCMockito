#!/bin/bash

FRAMEWORK_NAME="OCMockito"

MACOS_ARCHIVE_PATH="./build/archives/macos.xcarchive"
IOS_ARCHIVE_PATH="./build/archives/ios.xcarchive"
IOS_SIMULATOR_ARCHIVE_PATH="./build/archives/ios_sim.xcarchive"
TV_ARCHIVE_PATH="./build/archives/tv.xcarchive"
TV_SIMULATOR_ARCHIVE_PATH="./build/archives/tv_sim.xcarchive"
WATCH_ARCHIVE_PATH="./build/archives/watch.xcarchive"
WATCH_SIMULATOR_ARCHIVE_PATH="./build/archives/watch_sim.xcarchive"

xcodebuild archive -scheme ${FRAMEWORK_NAME} -archivePath ${MACOS_ARCHIVE_PATH} -sdk macosx SKIP_INSTALL=NO
xcodebuild archive -scheme ${FRAMEWORK_NAME}-iOS -archivePath ${IOS_ARCHIVE_PATH} -sdk iphoneos SKIP_INSTALL=NO
xcodebuild archive -scheme ${FRAMEWORK_NAME}-iOS -archivePath ${IOS_SIMULATOR_ARCHIVE_PATH} -sdk iphonesimulator SKIP_INSTALL=NO
xcodebuild archive -scheme ${FRAMEWORK_NAME}-tvOS -archivePath ${TV_ARCHIVE_PATH} -sdk appletvos SKIP_INSTALL=NO
xcodebuild archive -scheme ${FRAMEWORK_NAME}-tvOS -archivePath ${TV_SIMULATOR_ARCHIVE_PATH} -sdk appletvsimulator SKIP_INSTALL=NO
xcodebuild archive -scheme ${FRAMEWORK_NAME}-watchOS -archivePath ${WATCH_ARCHIVE_PATH} -sdk watchos SKIP_INSTALL=NO
xcodebuild archive -scheme ${FRAMEWORK_NAME}-watchOS -archivePath ${WATCH_SIMULATOR_ARCHIVE_PATH} -sdk watchsimulator SKIP_INSTALL=NO

xcodebuild -create-xcframework \
  -framework ${MACOS_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
  -framework ${IOS_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
  -framework ${IOS_SIMULATOR_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
  -framework ${TV_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
  -framework ${TV_SIMULATOR_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
  -framework ${WATCH_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
  -framework ${WATCH_SIMULATOR_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
  -output "./build/${FRAMEWORK_NAME}.xcframework"
