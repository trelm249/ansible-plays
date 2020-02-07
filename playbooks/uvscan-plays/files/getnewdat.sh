#!/bin/bash
## A script to update the DAT files for uvscan.
## It needs elinks to do so and leverages the nimdax user as well.
## If elinks is not installed, it will be installed.

find /tmp/ -type f -name avv* -exec rm {} \;
rm -f ~/.elinks/*
version=$(elinks http://update.nai.com/products/commonupdater --dump | grep -e "avvdat-.*.zip$" |tail -n -1 |cut -c 52-66)
echo $version
cd /tmp
wget -r -t 5 -l1 --no-parent -nd http://update.nai.com/products/commonupdater/$version
unzip -o avv*.zip
mv -f *.dat /usr/local/uvscan/
find . -type f -name avvdat*.zip -delete
chmod 644 /usr/local/uvscan/*.dat



