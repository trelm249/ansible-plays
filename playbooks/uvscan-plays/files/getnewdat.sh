#!/bin/bash
## A script to update the DAT files for uvscan.

find /tmp/ -type f -name avv* -exec rm {} \;
cd /tmp
for i in {9520..9999}; do curl --output avvdat-$i.zip http://update.nai.com/products/commonupdater/avvdat-$i.zip; done
find ./ -type f -name 'avvdat-*.zip' -size -20b -delete
unzip -o $(ls -ls| tail -n -1 |awk '{ print $10 }')
mv -f *.dat /usr/local/uvscan/
find . -type f -name avvdat*.zip -delete
chmod 644 /usr/local/uvscan/*.dat



