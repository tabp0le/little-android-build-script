#!/bin/bash

### Little Android Build Script
### Copyright 2017, Tab Fitts

echo " "
echo "Updating ota.xml."
echo " "

source config.conf

cd $OTAPATH && sed -i -- 's/'"$ROMPREFIX"'.\+zip/'"$FILENAME"'/g' $OTAXML

echo " "
echo "Commiting and uploading ota.xml changes to Github"

git commit $OTAXML -S -m "'$OTACOMMITMSG'" && git push $OTAREPO

echo "Update ota.xml complete."
