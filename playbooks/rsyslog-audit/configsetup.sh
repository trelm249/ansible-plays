#!/bin/bash
#Author: Trae Elmore
#Filename: /home/user/rsyslog-certs/configsetup.sh
#Date Created: 20180716
#Last Modified: 20180716
#Description: This file is run in the home directiory in the rsyslog-certs subdirectory on the rsyslog server. It updates the client certificate template and then generates an rsyslog client cert.
#Usage - ./configsetup.sh client-shortname client-ip-address

certhost=$1
certip=$2
oldserial=$(grep -e "^serial" ./client.cfg | awk '{ print $3 }')
newserial=$(( oldserial + 1 ))
oldcn=$(grep -e "^cn " ./client.cfg | awk '{ print $3 }')
oldfqdn=$(grep -e "^dns_name " ./client.cfg | awk '{ print $3 }')
oldip=$(grep -e "^ip_address " ./client.cfg | awk '{ print $3 }')
newcn=\"$certhost\"
newfqdn=\"$certhost.subdomain.domain\"
newip=\"$certip\"

echo $oldcn
echo $newcn
sed -i '/^cn/s/'$oldcn'/'$newcn'/' ./client.cfg
sed -i '/^dns_name/s/'$oldfqdn'/'$newfqdn'/' ./client.cfg
sed -i '/^ip_address/s/'$oldip'/'$newip'/' ./client.cfg
sed -i '/^serial/s/'$oldserial'/'$newserial'/' ./client.cfg
certtool --generate-privkey --outfile rslclient-key.pem --sec-param Medium
certtool --generate-certificate --outfile rslclient-cert.pem --load-privkey rslclient-key.pem --template client.cfg --load-ca-certificate ca-cert.pem --load-ca-privkey ca-key.pem

