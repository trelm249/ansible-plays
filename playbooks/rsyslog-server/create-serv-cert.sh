#!/bin/bash
cd /etc/pki/rsyslog/

certhost=$(hostname)
certip=$(nslookup $(hostname) |tail -2 |awk '{print $2}')
oldserial=$(grep -e "^serial" ./serv.tmpl | awk '{ print $3 }')
newserial=$(( oldserial + 1 ))
oldcn=$(grep -e "^cn " ./serv.tmpl | awk '{ print $3 }')
oldfqdn=$(grep -e "^dns_name " ./serv.tmpl | awk '{ print $3 }')
oldip=$(grep -e "^ip_address " ./serv.tmpl | awk '{ print $3 }')
newcn=\"$certhost\"
newfqdn=\"$certhost.sandbox.sb\"
newip=\"$certip\"

echo $oldcn
echo $newcn
sed -i '/^cn/s/'$oldcn'/'$newcn'/' ./serv.tmpl
sed -i '/^dns_name/s/'$oldfqdn'/'$newfqdn'/' ./serv.tmpl
sed -i '/^ip_address/s/'$oldip'/'$newip'/' ./serv.tmpl
sed -i '/^serial/s/'$oldserial'/'$newserial'/' ./serv.tmpl
certtool --generate-privkey --outfile rslserver-key.pem --sec-param High
certtool --generate-certificate --outfile rslserver-cert.pem --load-privkey rslserver-key.pem --template serv.tmpl --load-ca-certificate ca-cert.pem --load-ca-privkey ca-key.pem

