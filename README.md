# Little Android Build Script
My little Android build script by tabp0le

Feel free to use this build script and modify it according to your needs.

This will sync your android repos, setup your build environment, clean the install directory and upload the resulting .zip and md5 files.

Instructions:
1. Put the files in the root of your android build directory
2. Open the config file and change the device code name, sftp server information, device/md5sum naming & ssh private key to fit your needs
3. Open up a terminal window and type "chmod a+x *.sh"
4. Type "./syncbuild.sh" and press enter to build

Please note, currently only sftp is supported by this script. You must have your ssh key in your ~/.ssh folder, and it must be in your path. Feel free to change the script to fit your needs. (Such as ftp, ftps, scp, etc)

Additionally, you may add this to your roomservice.xml and it will sync with the rest of your tree.
```xml 
  <project path="build/tabp0le-labs" name="tabp0le/little-android-build-script" remote="github" revision="testing">
    <linkfile src="builddevice.sh" dest="builddevice.sh" />
    <linkfile src="otacommit.sh" dest="otacommit.sh" />
    <linkfile src="syncbuild.sh" dest="syncbuild.sh" />
    <linkfile src="upload-sftp.sh" dest="upload-sftp.sh" />
    <linkfile src="config.conf" dest="config.conf" />
  </project>
```
