#!/bin/bash

### Little Android Build Script
### Copyright 2017, Tab Fitts

echo " "
echo "Updating ota file."
echo " "

source config.conf

cd $OTAPATH && sed -i -- 's/'"$ROMPREFIX\_"'.\+zip/'"$FILENAME"'/g' $OTAXML
sed -i -- 's/.*build_date.*/"build_date":'\"$BUILD_DATE\",'/' $OTAXML
sed -i -- 's/.*md5.*/"md5":'\"$MD5\",'/' $OTAXML
sed -i -- 's/.*filesize.*/"filesize":'\"$FILESIZE\",'/' $OTAXML
sed -i -- 's/'"$ROMPREFIX\_"'.\+_changelog.txt/'"$CHANGELOG"'/g' $OTAXML

echo " "
echo "Committing and pushing changes"

git commit $OTAXML -m "'$OTACOMMITMSG'" && git push $OTAREPO

echo "Update ota complete."
