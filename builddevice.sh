#!/bin/bash

### Little Android Build Script
### Copyright 2017, Tab Fitts

source config.conf

. build/envsetup.sh && breakfast $DEVICECODENAME

if [ $MAKECLEAN -eq 1 ]
then
    make clean && brunch $DEVICECODENAME
else
    make installclean && brunch $DEVICECODENAME
fi
