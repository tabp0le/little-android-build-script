# little-android-build-script
My little Android build script by tabp0le

Feel free to use this build script and modify it according to your needs.

This will sync your android repos, setup your build environment, clean the install directory and upload the resulting .zip and md5 files.

Instructions:
1. Put syncbuild.sh, upload-sftp & config.conf in the root of your android build directory
2. Change the device code name, sftp server information, device/md5sum naming & ssh private key to fit your needs
3. Open up a terminal window and type "chmod a+x syncbuild.sh upload-sftp"
4. Type ". syncbuild.sh" and press enter to build
