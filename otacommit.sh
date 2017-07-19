#!/bin/bash

### Little Android Build Script
### Copyright 2017, Tab Fitts

echo " "
echo "Updating ota file."
echo " "

source config.conf

cd $OTAPATH && git reset --hard &&git fetch &&git pull

sed -i -- 's/'"<VersionName"'.\+<\/\VersionName>/'"\<VersionName>$OTA_VERSION<\/\VersionName>"'/g' $OTAXML
sed -i -- 's/'"$ROMPREFIX\_"'.\+zip/'"$FILENAME"'/g' $OTAXML
sed -i -- 's/'"<FileSize"'.\+<\/\FileSize>/'"\<FileSize type=\"\integer\"\>$FILESIZE<\/\FileSize>"'/g' $OTAXML
sed -i -- 's/'"<VersionNumber"'.\+<\/\VersionNumber>/'"\<VersionNumber type=\"\integer\"\>$BUILD_DATE<\/\VersionNumber>"'/g' $OTAXML
sed -i -- 's/'"<CheckMD5"'.\+<\/\CheckMD5>/'"\<CheckMD5>$MD5<\/\CheckMD5>"'/g' $OTAXML

echo " "
echo "Committing and pushing changes"

git commit $OTAXML -m "'$OTACOMMITMSG'" && git push $OTAREPO

echo "Update ota complete."
