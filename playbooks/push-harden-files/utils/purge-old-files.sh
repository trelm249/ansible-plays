#!/bin/bash
find /var/log/*.log -type f -empty -delete
find /var/log -type f -mtime +99 -delete
find /var/log/audit/ -type f -mtime +99 -delete

