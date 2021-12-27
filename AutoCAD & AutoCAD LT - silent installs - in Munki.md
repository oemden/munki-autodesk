# AutoCAD & AutoCAD LT "silent installs" in Munki



## Versions 2015 - 2018

The only way at the time was to create your own package to silently install standalone 'box' software.

**WARNING**: here, the Installer `Installer Autodesk AutoCAD LT 2015 for Mac.pkg` is the **FRENCH** installer. Autodesk doesn't seems to do localisation.

I use Packages.app to create a package, and always try to use the ACAD version for the package version. Easier to manage.

#### The .pkg contains a Payload in /tmp.

A script and the copy of the Installer 

- `Installer Autodesk AutoCAD LT 2015 for Mac.pkg` # the .pkg installer
- `installACADLT2015` # the script called by the postinstall script. 

#### The post-installation script : 

- `Install-ACADLT2015-BusinessUnit.sh`

Usage is explained in the scripts:

 -  pkgPath: Path to the installer pkg file.
 -  licenseType: "N" for Network license, "S" for Standalone license.
 -  serialNumber: Serial Number to install the product, in the format of xxx-xxxxxxxx.
 -  productKey: Product Key of the product, e.g., 777G1 for AutoCAD 2015 for Mac.
 -  networkServer: Optional. Input the network license server name if license type is "Network".

The last working version with this method is the 2018 one. 

## Version 2019 - 2020

The above method has been suppressed by Autodesk. 

Forcing companies to go full subscription / IDs.

I didn't pushed it much, the installer wants IDs and we had Serial Numbers - was a big pain until we fully switched to subscription.

The script `Preinstall_for_AutoCADLT2020_update_from_munki.sh` is a `preinstall_script` for munki.

The Autodesk Update install FAILS via  cli/munki if the app is present!

The script simply removes the App. Dirty but works as expected.


## Versions 2021 - 2022

Back to so-called silent install wich is not. 

Since 2021 there is a new method. 
Autodesk provide an .app ( thus not followind at all Apple guidelines ) to install the software.

#### Silent Install : 

This is **NOT** a silent Install at all and a end user **MUST** clic on windows to pursue the installation. 

This also mean the install can not be runned from the login window.


#### munkiimport : 

Importing in munki is a bit tricky, you need to specify :

```
- --postinstall_script 
	- # Specifies the postinstallscript ( aka the script with the oneliner provided by Autodesk )
- --destination 
	- # Specifies where to copy the .app installer ( I choose the /tmp folder )
- --destinationitem 
	- # seems not needed finally, I do not use this one.
- --file 
	- # Specifies where is the ACAD .app so munki knows it is installed. & doesn't do an never ending loop.
```

Here is an example:

```
munkiimport --destinationpath /tmp /Volumes/Installer/Install\ Autodesk\ AutoCAD\ LT\ 2022\ for\ Mac.app \
--postinstall_script=/path/to/Silent_install_of_AutoCADLT2022_from_munki.sh \
--file=/Applications/Autodesk/AutoCAD\ LT\ 2022/AutoCAD\ LT\ 2022.app \
## --destinationitem=/Install\ Autodesk\ AutoCAD\ LT\ 2022\ for\ Mac.app # not necessary
```

> You may have to finetune a bit the pkginfo. It happens that using the --file switch auto completed the pkginfo.



