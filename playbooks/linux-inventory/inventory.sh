#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "Must run $ARGV[0] as sudo/root!"
  exit 1
fi

date=$(date)

# In-script aliases to keep the below code clean

## Cuts the output by colons and returns the second field
cut_="cut -d: -f 2"

## seds the output and removes all spaces from the beginning of the  line.
sed_(){ 
  echo "$1" | sed -e "s/^ \+//g" 
}

# Nab client info

## dmidecode type 1 -> System Information
ddc1=$(dmidecode -t 1);
ddc0=$(dmidecode -t 0);

make=$(sed_ "$(echo "$ddc1"|grep Manuf |$cut_)")
model=$(sed_ "$(echo "$ddc1"|grep Product |$cut_)")
serial=$(sed_ "$(echo "$ddc1"|grep Serial |$cut_)")
bversion=$(sed_ "$(echo "$ddc0"|grep Version)")

### dmidecode type 4 -> Processor Information
ddc4=$(dmidecode -t 4);

cpuModel=$(sed_ "$(echo "$ddc4"| grep Version  |$cut_)")
cpuSocket=$(sed_ "$(echo "$ddc4"| grep Upgrade |$cut_)")
cpuCount=$(sed_ "$(echo "$ddc4"| grep "Core Co" |$cut_)")
cpuThread=$(sed_ "$(echo "$ddc4"| grep "Thread Co" |$cut_)")

## dmidecode type 16 -> Physical Memory Array (Total Possible RAM)
ddc16=$(dmidecode -t 16);

memTotal=$(sed_ "$(echo "$ddc16"| grep Max |$cut_)")
memSlots=$(sed_ "$(echo "$ddc16"| grep Num |$cut_)")

## dmidecode type 19 -> Memory Array Mapped Address (Total Installed RAM)
ddc19=$(dmidecode -t 19);

memInstalled=$(sed_ "$(echo "$ddc19"| grep Rang |$cut_)")

## dmidecode type 20 -> Individual Memory Stick Info
ddc20=$(dmidecode -t 20);

memSlotsUsed=$(echo "$ddc20"| grep "Range Size"|wc -l)

# Standard stuff

## hostname of the box
hostname=$(hostname)

## gets each interface, it's IP and physical address
ips=$(ifconfig -a | tr -s ' ' | grep -v "TX\|RX\|inet6\|device")

## Grabs partitions on the system. Ignores the cd drive
parts=$(fdisk -l | grep Disk | grep -v "mapp\|label\|identif"| cut -d , -f 1)

## grabs partition usage in human-radable format
disks=$(df -h -x tmpfs -x devtmpfs -x iso9660| grep -v tmpfs)

## grabs the current OS version
osVer=$(cat /etc/system-release)

## gets any RPM package that's installed and not from RedHat and ignores
## gpg-pubkey packages.
#nonRHpkgs=$(rpm -qa --qf "%-20{NAME}\t%-15{VERSION}\t%{VENDOR}\t\n" | grep -v "Red Hat\|gpg" | grep -v "Fedora")
nonRHpkgs=$(rpm -qa --qf "%-20{NAME}\t%-15{VERSION}\t%{VENDOR}\t\n" | grep -v "Red Hat\|gpg")

echo -ne "=================================================================\n"
echo -ne "  $hostname @ $date\n"
echo -ne "  $osVer\n"
echo -ne "  $make $model ($serial)\n"
echo -ne "  $make $model BIOS $bversion\n"
echo -ne "=================================================================\n"
echo -ne "Hardware Information:\n"
echo -ne "-----------------------------------------------------------------\n"
echo -ne "Memory: $memInstalled installed, $memTotal supported"
echo -ne " ($memSlotsUsed / $memSlots slots in use)\n"
echo -ne "CPU:    $cpuModel ($cpuCount C, $cpuThread T)\n\n"
echo -ne "Partitions (Tempfs not shown):\n"
echo -ne "$disks\n\n"
echo -ne "Physical Disks:\n"
echo -ne "$parts\n"
echo -ne "=================================================================\n"
echo -ne "Network:\n"
echo -ne "-----------------------------------------------------------------\n"
echo -ne "$ips\n";
echo -ne "=================================================================\n"
echo -ne "Non-RedHat Software:\n"
echo -ne "-----------------------------------------------------------------\n"
echo -ne "Package Name\t\tVersion\t\tVendor\n"
echo -ne "-----------------------------------------------------------------\n"
echo -ne "$nonRHpkgs\n\n"
echo -ne "Hint:\n"
echo -ne "  Fedora Project = Fedora's EPEL Repo\n"
echo -ne "=================================================================\n"
echo -ne "Done."


exit 0

