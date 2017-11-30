#!/bin/bash
DESC_FILE="/root/pkg/DESCRIPTION"

if [ ! -f $DESC_FILE ]; then
  echo "The description file at $DESC_FILE couldn't be found"
  echo "Make sure you mounted the package using --volume /pkd/dir:/root/pkg"
  exit 1
fi

PKG_NAME=$(sed -n -e '1p' -e '/^Package:/!d' $DESC_FILE \
  | awk '{gsub("Package:[ ]*","")}1')

echo "Building package: $PKG_NAME"
RD CMD build /root/pkg

PKG_BUILD_NAME=$(find /root/ -name $PKG_NAME*.tar.gz)
echo "Testing the '$PKG_BUILD_NAME' package"
RD CMD check --as-cran $PKG_BUILD_NAME

