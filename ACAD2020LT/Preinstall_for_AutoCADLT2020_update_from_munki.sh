#!/bin/bash
##
## Silent Update of AutoCAD(LT) from munki
## oem at oemden dot com
## the installer fails if AutoCAD ( LT ) is present.
## So we need the app to be present so munki detects the update,
## BUT we have to delete it prior to install the update via munki.

## 20211216
version=0.2

## must run sudo
if [ `id -u` -ne 0 ] ; then
	printf "must be run as sudo, exiting"
	echo
	exit 1
fi

## Prefix all paths with $TARGET
if [ "$3" == "/" ]; then
    TARGET=""
else
    TARGET="$3"
fi


ACADLT_DIR="${TARGET}/Applications/Autodesk/AutoCAD LT 2020"

if [[ -d "${ACADLT_DIR}" ]] ; then
 rm -Rf "${ACADLT_DIR}"
 echo "Deleting AutoCAD prior to install to prevent damn failure"
 ## Note : Dirty but it works.
fi

exit 0

