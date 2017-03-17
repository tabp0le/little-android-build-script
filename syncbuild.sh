#!/bin/bash

### Little Android Build Script
### Copyright 2017, Tab Fitts

repo sync

source config.conf
export ANDROID_BUILD_DIR=$(pwd)

. build/envsetup.sh && breakfast $DEVICECODENAME && make installclean && brunch $DEVICECODENAME

echo " "
echo "Build completed. Preparing to upload."
echo " "

cd $OUT

export FILENAME=$(ls |grep -m 1 $ROMPREFIX*.zip)
export MD5SUMNAME=$(ls |grep -m 1 $ROMPREFIX*.md5sum)

cd $ANDROID_BUILD_DIR

echo " "
echo "Uploading..."

sh upload-sftp.sh $FTPUSER@$FTPSERVER:$FTPPATH $OUT/$FILENAME $OUT/$MD5SUMNAME
sh upload-sftp.sh $FTPUSER@$FTPSERVER:$FTPPATH CHANGELOG.mkdn ||

echo " "
echo "Upload complete."
echo " "

if [ $UPDATEOTAXML -eq 1 ]
then
    sh otacommit.sh
    cd $ANDROID_BUILD_DIR
    echo " "
    echo " "
    echo "Device build and upload complete!"
else
    echo " "
    echo " "
    echo "Device build and upload complete!"

fi
