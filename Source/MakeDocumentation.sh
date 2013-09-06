DOXYGEN=${DOXYGEN-/Applications/Doxygen.app/Contents/Resources/doxygen}

if ! [ -f $DOXYGEN ]; then
  echo :: error : Requires Doxygen in the `dirname $DOXYGEN` folder
  exit 1
fi

$DOXYGEN "../Documentation/Doxyfile"

# Generate Xcode documentation set
pushd build/Documentation
make
popd
