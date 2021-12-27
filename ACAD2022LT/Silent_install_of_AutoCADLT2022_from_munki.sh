#!/bin/bash
##
## Silent install of AutoCAD(LT) from munki
## almost Helpful SOURCE:
## https://help.autodesk.com/view/ACD/2021/ENU/?guid=Installation_AutoCAD_Install_ACDMAC_acdmac_install_product_silently_html
## oem at oemden dot com
## 20211216
version=0.2
## munkiimport line :
## munkiimport --destinationpath /tmp /Volumes/Installer/Install\ Autodesk\ AutoCAD\ LT\ 2022\ for\ Mac.app --postinstall_script=/path/to/Silent_install_of_AutoCADLT2022_from_munki.sh --file=/Applications/Autodesk/AutoCAD\ LT\ 2022/AutoCAD\ LT\ 2022.app --destinationitem=/Install\ Autodesk\ AutoCAD\ LT\ 2022\ for\ Mac.app

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

echo "Installing AutoCAD silently"
"${TARGET}"/tmp/Install\ Autodesk\ AutoCAD\ LT\ 2022\ for\ Mac.app/Contents/Helper/Setup.app/Contents/MacOS/Setup –silent

## TOTALLY NOT silent at all. Come on Autodesk...
