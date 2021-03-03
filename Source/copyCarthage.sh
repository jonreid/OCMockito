#!/bin/bash

CARTHAGE_BUILD=../../../Build/OCHamcrest.xcframework
LOCAL_FRAMEWORK=../Frameworks/OCHamcrest-8.0.0/

if [ -e $CARTHAGE_BUILD ] && [ ! -e $LOCAL_FRAMEWORK/OCHamcrest.xcframework ]; then
  echo "Copying Carthage OCHamcrest"
  mkdir -p $LOCAL_FRAMEWORK
  cp -pR $CARTHAGE_BUILD $LOCAL_FRAMEWORK/OCHamcrest.xcframework
else
  echo "Skipping Carthage copy"
fi
