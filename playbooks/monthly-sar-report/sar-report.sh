#!/bin/bash
###NAME= sar-report.sh
###Where= place in /usr/local/bin
###USAGE= /usr/local/bin/sar-report.sh >>~/$HOSTNAME.stats.$(date+%F)
#####For RHEL 6 and up
echo -e "Hostname:\t$(hostname)"
echo -e "System OS:\t$(cat /etc/redhat-release)\n"
echo -e "CPU Core Count:\t$(cat /proc/cpuinfo |grep "core id"|wc -l)"
echo -e "Total Memory:\t$(free -h |grep Mem |awk '{print $2}')\n"
echo -e "CPU % idle for 30 days"
for i in {01..30}; do statdate=$(date -r /var/log/sa/sa$i +%F); sar -u -f /var/log/sa/sa$i 2>/dev/null |grep Average |awk '{print "'$statdate'\t"$8}'; done
echo -e "\n"
echo -e "%RAM Used for 30 days"
for i in {01..30}; do statdate=$(date -r /var/log/sa/sa$i +%F); sar -r -f /var/log/sa/sa$i 2>/dev/null |grep Average |awk '{print "'$statdate'\t"$4}'; done
echo -e "\n"
echo -e "%SWAP Used for 30 days"
for i in {01..30}; do statdate=$(date -r /var/log/sa/sa$i +%F); sar -S -f /var/log/sa/sa$i 2>/dev/null |grep Average |awk '{print "'$statdate'\t"$4}'; done
echo -e "\n"
echo -e "IO - transactions per second\tand\tbytes written per second"
for i in {01..30}; do statdate=$(date -r /var/log/sa/sa$i +%F); sar -b -f /var/log/sa/sa$i 2>/dev/null |grep Average |awk '{print "'$statdate'\t"$2"\t\t\t\t"$6}'; done
echo -e "\n"
echo -e "Average Load:\tRun Queue\tand\tLoad Averages for 30 days"
for i in {01..30}; do statdate=$(date -r /var/log/sa/sa$i +%F); sar -q -f /var/log/sa/sa$i 2>/dev/null |grep Average |awk '{print "'$statdate'\t"$2"\t\t\t\t"$6}'; done
echo -e "\n"
echo -e "Average per\tInterface\tPackets RX per second\tand\tPackets TX per second\tfor 30 days"
for i in {01..30}; do statdate=$(date -r /var/log/sa/sa$i +%F); sar -n DEV -f /var/log/sa/sa$i 2>/dev/null |grep -vE "(lo|vnet|virbr)" |grep Average 2>/dev/null|awk '{print "'$statdate'\t"$2"\t"$3"\t\t\t\t"$4}'; done
echo -e "\n"
echo -e "File System Storage Consumption"
df -hlT --sync -x tmpfs -x devtmpfs -x iso9660
echo -e "\n"
echo -e "File System Inode Consumption"
df -ilT --sync -x tmpfs -x devtmpfs -x iso9660
