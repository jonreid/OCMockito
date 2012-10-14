#!/bin/sh
source environment.sh

LCOV_PATH=${SRCROOT}/TestSupport/lcov-1.9/bin
OBJ_DIR=${OBJECT_FILE_DIR_normal}/${NATIVE_ARCH}

# Clean out the old data
"${LCOV_PATH}/lcov" -d "${OBJ_DIR}" --zerocounters
