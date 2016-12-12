#!/bin/bash

PACKAGE_NAME=plusinit
VERSION_MAJOR=1
VERSION_MINOR=6
VERSION_BUILD=2
VERSION="$VERSION_MAJOR.$VERSION_MINOR-$VERSION_BUILD"
SEP="_"

cd package

# Create control file
CONTROL_FILE="DEBIAN/control"
echo "Package: ${PACKAGE_NAME}" > "$CONTROL_FILE"
echo "Version: $VERSION" >> "$CONTROL_FILE"
echo "Section: misc" >> "$CONTROL_FILE"
echo "Priority: optional" >> "$CONTROL_FILE"
echo "Architecture: all" >> "$CONTROL_FILE"
echo "Essential: no" >> "$CONTROL_FILE"
echo "Installed-Size: `du -sc etc usr opt | grep total | awk '{ print $1 }'`" >> "$CONTROL_FILE"
echo "Maintainer: Samuel Longchamps <samuel.longchamps@usherbrooke.ca>" >> "$CONTROL_FILE"
echo "Homepage: http://plus-us.gel.usherbrooke.ca/plusinit" >> "$CONTROL_FILE"
echo "Depends: rsync, dconf-gsettings-backend, pluspanel, plustutodesklet" >> "$CONTROL_FILE"
echo "Description: PLUS initialization for common settings package" >> "$CONTROL_FILE"
echo " Initializes various settings for the PLUS distribution in order to standardize the experience for all users on a system." >> "$CONTROL_FILE"

# Create md5sum
find . -type f ! -regex '.*.hg.*' ! -regex '.*?debian-binary.*' ! -regex '.*?DEBIAN.*' -printf '"%P" ' | xargs md5sum > DEBIAN/md5sums

cd ..

dpkg-deb -b package $PACKAGE_NAME$SEP$VERSION"_all.deb"
