#!/bin/bash

### Little Android Build Script
### Copyright 2017, Tab Fitts

source config.conf
export ANDROID_BUILD_DIR=$(pwd)
chmod a+x otacommit.sh upload-sftp.sh

if [ $REPOSYNC -eq 1 ]
then
    repo sync -f --force-sync -j24
else
    echo " "
fi

. build/envsetup.sh && breakfast $DEVICECODENAME

source config.conf
export BUILD_DATE=$(date +%Y%m%d)

if [ $MAKECLEAN -eq 1 ]
then
    make clean && brunch $ROMPREFIX_$DEVICECODENAME-userdebug -j24
else
    make installclean && brunch $ROMPREFIX_$DEVICECODENAME-userdebug -j24
fi

echo " "
echo "Build completed."
echo " "

cd $OUT

export FILENAME=$(ls |grep -m 1 $ROMPREFIX*.zip)
export MD5SUMNAME=$(ls |grep -m 1 $ROMPREFIX*.md5sum)
export CHANGELOG=$(ls |grep -m 1 $ROMPREFIX*changelog.txt)
export FILESIZE=$(stat -c%s $FILENAME)
export MD5=$(md5sum $FILENAME | awk '{ print $1 }')
export OTA_VERSION=$(echo ${FILENAME%.*})

cd $ANDROID_BUILD_DIR

if [ $UPLOADFTP -eq 1 ]
then
    echo " "
    echo "Uploading..."
    sh upload-sftp.sh $FTPUSER@$FTPSERVER:$FTPPATH $OUT/$FILENAME $OUT/$MD5SUMNAME
    sh upload-sftp.sh $FTPUSER@$FTPSERVER:$FTPPATH $OUT/$CHANGELOG ||
    echo " "
    echo "Upload complete."
    echo " "
else
    echo " "
fi

if [ $UPDATEOTAXML -eq 1 ]
then
    ./otacommit.sh
    cd $ANDROID_BUILD_DIR
    echo " "
    echo " "
    echo "Little Android Build Script Completed!"
else
    echo " "
    echo " "
    echo "Little Android Build Script Completed!"

fi
