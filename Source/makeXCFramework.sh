#!/bin/bash
# Use this script to create an XCFramework bundle that includes the frameworks necessary to build
# for multiple platforms (iOS, macOS, visionOS, tvOS, watchOS), including Simulator builds. Please
# beware that the script will fail when creating archives for xros/xrsimulator on computers running
# macOS on Intel architecture since the `-destination generic/platform=visionOS ...` is missing on
# that architecture.

XCODE_PROJECT_PATH="OCMockito.xcodeproj"
FRAMEWORK_NAME="OCMockito"

MACOS_ARCHIVE_PATH="./build/archives/macos.xcarchive"
CATALYST_ARCHIVE_PATH="./build/archives/mac_catalyst.xcarchive"
IOS_ARCHIVE_PATH="./build/archives/ios.xcarchive"
IOS_SIMULATOR_ARCHIVE_PATH="./build/archives/ios_sim.xcarchive"
TV_ARCHIVE_PATH="./build/archives/tv.xcarchive"
TV_SIMULATOR_ARCHIVE_PATH="./build/archives/tv_sim.xcarchive"
WATCH_ARCHIVE_PATH="./build/archives/watch.xcarchive"
WATCH_SIMULATOR_ARCHIVE_PATH="./build/archives/watch_sim.xcarchive"
XR_ARCHIVE_PATH="./build/archives/xr.xcarchive"
XR_SIMULATOR_ARCHIVE_PATH="./build/archives/xr_sim.xcarchive"

xcodebuild archive -project ${XCODE_PROJECT_PATH} -scheme ${FRAMEWORK_NAME} -archivePath ${MACOS_ARCHIVE_PATH} -destination 'generic/platform=macOS' SKIP_INSTALL=NO
xcodebuild archive -project ${XCODE_PROJECT_PATH} -scheme ${FRAMEWORK_NAME} -archivePath ${CATALYST_ARCHIVE_PATH} -destination 'generic/platform=macOS,variant=Mac Catalyst' SKIP_INSTALL=NO
xcodebuild archive -project ${XCODE_PROJECT_PATH} -scheme ${FRAMEWORK_NAME} -archivePath ${IOS_ARCHIVE_PATH} -destination "generic/platform=iOS" SKIP_INSTALL=NO
xcodebuild archive -project ${XCODE_PROJECT_PATH} -scheme ${FRAMEWORK_NAME} -archivePath ${IOS_SIMULATOR_ARCHIVE_PATH} -destination "generic/platform=iOS Simulator" SKIP_INSTALL=NO
xcodebuild archive -project ${XCODE_PROJECT_PATH} -scheme ${FRAMEWORK_NAME} -archivePath ${TV_ARCHIVE_PATH} -destination "generic/platform=tvOS" SKIP_INSTALL=NO
xcodebuild archive -project ${XCODE_PROJECT_PATH} -scheme ${FRAMEWORK_NAME} -archivePath ${TV_SIMULATOR_ARCHIVE_PATH} -destination "generic/platform=tvOS Simulator" SKIP_INSTALL=NO
xcodebuild archive -project ${XCODE_PROJECT_PATH} -scheme ${FRAMEWORK_NAME} -archivePath ${WATCH_ARCHIVE_PATH} -destination "generic/platform=watchOS" SKIP_INSTALL=NO
xcodebuild archive -project ${XCODE_PROJECT_PATH} -scheme ${FRAMEWORK_NAME} -archivePath ${WATCH_SIMULATOR_ARCHIVE_PATH} -destination "generic/platform=watchOS Simulator" SKIP_INSTALL=NO
xcodebuild archive -project ${XCODE_PROJECT_PATH} -scheme ${FRAMEWORK_NAME} -archivePath ${XR_ARCHIVE_PATH} -destination "generic/platform=visionOS" SKIP_INSTALL=NO
xcodebuild archive -project ${XCODE_PROJECT_PATH} -scheme ${FRAMEWORK_NAME} -archivePath ${XR_SIMULATOR_ARCHIVE_PATH} -destination "generic/platform=visionOS Simulator" SKIP_INSTALL=NO

xcodebuild -create-xcframework \
  -archive ${MACOS_ARCHIVE_PATH} -framework ${FRAMEWORK_NAME}.framework \
  -archive ${CATALYST_ARCHIVE_PATH} -framework ${FRAMEWORK_NAME}.framework \
  -archive ${IOS_ARCHIVE_PATH} -framework ${FRAMEWORK_NAME}.framework \
  -archive ${IOS_SIMULATOR_ARCHIVE_PATH} -framework ${FRAMEWORK_NAME}.framework \
  -archive ${TV_ARCHIVE_PATH} -framework ${FRAMEWORK_NAME}.framework \
  -archive ${TV_SIMULATOR_ARCHIVE_PATH} -framework ${FRAMEWORK_NAME}.framework \
  -archive ${WATCH_ARCHIVE_PATH} -framework ${FRAMEWORK_NAME}.framework \
  -archive ${WATCH_SIMULATOR_ARCHIVE_PATH} -framework ${FRAMEWORK_NAME}.framework \
  -archive ${XR_ARCHIVE_PATH} -framework ${FRAMEWORK_NAME}.framework \
  -archive ${XR_SIMULATOR_ARCHIVE_PATH} -framework ${FRAMEWORK_NAME}.framework \
  -output "./build/${FRAMEWORK_NAME}.xcframework"
