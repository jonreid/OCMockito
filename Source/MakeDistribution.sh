VERSION=0.22
OCHAMCRESTVERSION=1.7
DISTFILE=OCMockito-${VERSION}
DISTPATH=build/${DISTFILE}
PROJECTROOT=..
DOCSET=build/Documentation/org.mockito.OCMockito.docset

echo Preparing clean build
rm -rf build
mkdir build

echo Building OCMockito - Debug
xcodebuild -configuration Debug -target OCMockito
OUT=$?
if [ "${OUT}" -ne "0" ]; then
    echo OCMockito release build failed
    exit ${OUT}
fi

echo Building OCMockitoIOS - Debug
source MakeIOSFramework.sh
OUT=$?
if [ "${OUT}" -ne "0" ]; then
    echo OCMockitoIOS release build failed
    exit ${OUT}
fi

echo Building Documentation
source MakeDocumentation.sh

echo Assembling Distribution
rm -rf "${DISTPATH}"
mkdir "${DISTPATH}"
cp -R "build/Debug/OCMockito.framework" "${DISTPATH}"
cp -R "build/Debug/OCMockitoIOS.framework" "${DISTPATH}"
cp "${PROJECTROOT}/README.md" "${DISTPATH}"
cp "${PROJECTROOT}/CHANGES.txt" "${DISTPATH}"
cp "${PROJECTROOT}/LICENSE.txt" "${DISTPATH}"
cp "${PROJECTROOT}/LICENSE-mockito.txt" "${DISTPATH}"
cp -R "${PROJECTROOT}/Examples" "${DISTPATH}"
cp -R "${PROJECTROOT}/Frameworks/OCHamcrest-${OCHAMCRESTVERSION}" "${DISTPATH}"
mkdir "${DISTPATH}/Documentation"
cp -R "${DOCSET}" "${DISTPATH}/Documentation"
cp "${PROJECTROOT}/Documentation/Makefile" "${DISTPATH}/Documentation"
cp "${PROJECTROOT}/Documentation/README.txt" "${DISTPATH}/Documentation"

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
