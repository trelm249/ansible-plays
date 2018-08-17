#!/bin/bash
#verify that the dat file is less than 7 days old and scans are more recent than 7 days

##setting up some necessary variables
d7=604800 #How many seconds are in 7 days
today=$(date +%s) #Todays date in the number of seconds since the start of the unix epoch.
told=$(expr $today - $d7) #The value of 7 days ago from today in the number of seconds since the start of the unix epoch.
lscan=$(ls -r /var/log/uvscan-*.lo* | head -1 | xargs date +%s -r) #the date of the last av scan based on the last modified time of the most recent scan log.
datdate=$(ls /usr/local/uvscan/avvscan.dat | xargs date +%s -r) #the date of the last modified time of the DAT file.


# This section checks if scans are running at least every 7 days
COLUMN=UVSCAN-SCANS	# Name of the column
COLOR=green		# By default, everything is OK
MSG="UVSCAN Scheduled Scans"

if [ "$lscan" -gt "$told" ]; 
then
 COLOR=green
 MSG="${MSG}
 UVSCAN has scanned within a week
      "
else
 COLOR=red
 MSG="${MSG}
 UVSCAN has not scanned in 7 days
"
fi

# Tell Xymon about it
$XYMON $XYMSRV "status $MACHINE.$COLUMN $COLOR `date`

${MSG}
 "

####this section checks if the DAT file is newer than 7 days
COLUMN=UVSCAN-DAT-Currency	# Name of the column
COLOR=green		# By default, everything is OK
MSG="UVSCAN DAT Currency"

if [ "$datdate" -gt "$told" ]; 
then
 COLOR=green
 MSG="${MSG}
 UVSCAN DAT file is newer than 7 days
      "
else
 COLOR=red
 MSG="${MSG}
 UVSCAN DAT File is older than 7 days
"
fi

# Tell Xymon about it
$XYMON $XYMSRV "status $MACHINE.$COLUMN $COLOR `date`

${MSG}
 "

exit 0

