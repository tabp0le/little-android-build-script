#!/bin/bash

repo sync

source config.conf
export ANDROID_BUILD_DIR=$(pwd)

. build/envsetup.sh && breakfast $DEVICECODENAME && make installclean && brunch $DEVICECODENAME

echo " "
echo "Build completed. Preparing to upload."
echo " "

cd $OUT

export FILENAME=$(ls |grep -m 1 RR*.zip)
export MD5SUMNAME=$(ls |grep -m 1 RR*.md5sum)

cd $ANDROID_BUILD_DIR

echo " "
echo "Uploading..."

sh upload-sftp $FTPUSER@$FTPSERVER:$FTPPATH $OUT/$FILENAME $OUT/$MD5SUMNAME
sh upload-sftp $FTPUSER@$FTPSERVER:$FTPPATH CHANGELOG.mkdn ||

echo " "
echo "Upload complete...Updating ota.xml."
echo " "

cd $OTAPATH && sed -i -- 's/RR.\+zip/'"$FILENAME"'/g' $OTAXML

echo " "
echo "Commiting and uploading ota.xml changes to Github"

git commit $OTAXML -S -m "'$OTACOMMITMSG'"
git push $OTAREPO

cd $ANDROID_BUILD_DIR
echo " "
echo " "
echo "Device build and upload complete!"
