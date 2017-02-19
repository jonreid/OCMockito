VERSION=4.1.0
DISTFILE=OCMockito-${VERSION}
DISTPATH=build/${DISTFILE}
PROJECTROOT=..

echo Preparing clean build
rm -rf build
mkdir build

echo Building OCMockito - Release
xcodebuild -configuration Release -target OCMockito
OUT=$?
if [ "${OUT}" -ne "0" ]; then
    echo OCMockito release build failed
    exit ${OUT}
fi

echo Building OCMockitoIOS - Release
source MakeIOSFramework.sh
OUT=$?
if [ "${OUT}" -ne "0" ]; then
    echo OCMockitoIOS release build failed
    exit ${OUT}
fi

echo Assembling Distribution
rm -rf "${DISTPATH}"
mkdir "${DISTPATH}"
cp -R "build/Release/OCMockito.framework" "${DISTPATH}"
cp -R "build/Release/OCMockitoIOS.framework" "${DISTPATH}"
cp "${PROJECTROOT}/README.md" "${DISTPATH}"
cp "${PROJECTROOT}/CHANGES.md" "${DISTPATH}"
cp "${PROJECTROOT}/LICENSE.txt" "${DISTPATH}"
cp -R "${PROJECTROOT}/Examples" "${DISTPATH}"

find "${DISTPATH}/Examples" -type d \( -name 'build' -or -name 'xcuserdata' -or -name '.svn' -or -name '.git' \) | while read DIR
do
    rm -R "${DIR}";
done

find "${DISTPATH}/Examples" -type f \( -name '*.pbxuser' -or -name '*.perspectivev3' -or -name '*.mode1v3' -or -name '.DS_Store' -or -name '.gitignore' \) | while read FILE
do
    rm "${FILE}";
done

pushd build
zip --recurse-paths --symlinks ${DISTFILE}.zip ${DISTFILE}
open .
popd
