DOXYGEN=${DOXYGEN-/Applications/Doxygen.app/Contents/Resources/doxygen}

if ! [ -f $DOXYGEN ]; then
  echo :: warning : No documentation generated\; requires Doxygen in the `dirname $DOXYGEN` folder
else
  $DOXYGEN "../Documentation/Doxyfile"

  # Generate Xcode documentation set
  pushd build/Documentation
  make
  popd
fi
