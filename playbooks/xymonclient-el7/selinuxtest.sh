#!/bin/sh
## test the status of se linux on a client

COLUMN=SELinux	# Name of the column
COLOR=green		# By default, everything is OK
MSG="SE Linux status"

##
#Get the current selinux status and save it to a variable.
##
ENF=$(getenforce)
   
if [ "$ENF" = "disabled" ]; 
then
 COLOR=red
 MSG="${MSG}
 SELinux is Disabled
      "
elif [ "$ENF" = "permissive" ];
then
 COLOR=yellow
 MSG="${MSG}
 SELinux is Permissive
"
else
 COLOR=Green
 MSG="${MSG}
 SELinux is Enabled
"
fi

# Tell Xymon about it
$XYMON $XYMSRV "status $MACHINE.$COLUMN $COLOR `date`

${MSG}
 "

exit 0




