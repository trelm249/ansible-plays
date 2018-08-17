#!/bin/bash
#verify the system is running in fips kernel mode

#determine the current state of fips kernel mode
fipstest=$(cat /proc/sys/crypto/fips_enabled)

# This section checks if fips kernel mode is enabled and reports
COLUMN=FIPS-Kernel-Mode	# Name of the column
COLOR=green		# By default, everything is OK
MSG="Current FIPS Kernel Mode Status"

if [ "$fipstest" -eq "1" ]; 
then
 COLOR=green
 MSG="${MSG}
 The kernel is running in FIPS mode
      "
else
 COLOR=red
 MSG="${MSG}
 The kernel is not running in FIPS mode
"
fi

# Tell Xymon about it
$XYMON $XYMSRV "status $MACHINE.$COLUMN $COLOR `date`

${MSG}
 "

exit 0

