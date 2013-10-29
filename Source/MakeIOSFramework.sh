# First build the OS X framework to get its folder structure.
xcodebuild -configuration Release -target OCMockito -sdk macosx

# We'll copy the OS X framework to a new location, then modify it in place.
OSX_FRAMEWORK="build/Release/OCMockito.framework/"
IOS_FRAMEWORK="build/Release/OCMockitoIOS.framework/"

# Trigger builds of the static library for both the simulator and the device.
xcodebuild -configuration Release -target libocmockito -sdk iphoneos
OUT=$?
if [ "${OUT}" -ne "0" ]; then
    echo Device build failed
    exit ${OUT}
fi
xcodebuild -configuration Release -target libocmockito -sdk iphonesimulator
OUT=$?
if [ "${OUT}" -ne "0" ]; then
    echo Simulator build failed
    exit ${OUT}
fi

# Copy the OS X framework to the new location.
mkdir -p "${IOS_FRAMEWORK}"
rsync -q -a --delete "${OSX_FRAMEWORK}" "${IOS_FRAMEWORK}"

# Rename the main header.
mv "${IOS_FRAMEWORK}/Headers/OCMockito.h" "${IOS_FRAMEWORK}/Headers/OCMockitoIOS.h"

# Update all imports to use the new framework name.
IMPORT_EXPRESSION="s/#import <OCMockito/#import <OCMockitoIOS/g;"
find "${IOS_FRAMEWORK}" -name '*.h' -print0 | xargs -0 perl -pi -e "${IMPORT_EXPRESSION}"

# Delete the existing (OS X) library and the link to it.
rm "${IOS_FRAMEWORK}/OCMockito" "${IOS_FRAMEWORK}/Versions/Current/OCMockito"

# Create a new library that is a fat library containing both static libraries.
DEVICE_LIB="build/Release-iphoneos/libocmockito.a"
SIMULATOR_LIB="build/Release-iphonesimulator/libocmockito.a"
OUTPUT_LIB="${IOS_FRAMEWORK}/Versions/Current/OCMockitoIOS"

lipo -create "${DEVICE_LIB}" "${SIMULATOR_LIB}" -o "${OUTPUT_LIB}"

# Add a symlink, as required by the framework.
ln -s Versions/Current/OCMockitoIOS "${IOS_FRAMEWORK}/OCMockitoIOS"

# Update the name in the plist file.
NAME_EXPRESSION="s/OCMockito/OCMockitoIOS/g;"
perl -pi -e "${NAME_EXPRESSION}" "${IOS_FRAMEWORK}/Resources/Info.plist"
