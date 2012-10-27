#!/bin/sh
source environment.sh

LCOV_INFO=Coverage.info
LCOV_PATH=${SRCROOT}/TestSupport/lcov-1.9/bin
OBJ_DIR=${OBJECT_FILE_DIR_normal}/${NATIVE_ARCH}

# Remove old report
pushd ${BUILT_PRODUCTS_DIR}
	if [ -e lcov ]; then
		rm -r lcov
	fi
popd

# Create and enter the coverage directory
cd ${BUILT_PRODUCTS_DIR}
mkdir lcov
cd lcov

# Gather coverage data
"${LCOV_PATH}/lcov" -b "${SRCROOT}" -d "${OBJ_DIR}" --capture -o ${LCOV_INFO}

# Exclude things we don't want to track
"${LCOV_PATH}/lcov" -d "${OBJ_DIR}" --remove ${LCOV_INFO} "/Applications/Xcode.app/*" -o ${LCOV_INFO}
"${LCOV_PATH}/lcov" -d "${OBJ_DIR}" --remove ${LCOV_INFO} "TestSupport/*" -o ${LCOV_INFO}

# Generate and display html
"${LCOV_PATH}/genhtml" --output-directory . ${LCOV_INFO}
open index.html
