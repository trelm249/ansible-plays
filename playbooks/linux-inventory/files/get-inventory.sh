#!/bin/bash
#For a report
/usr/local/bin/inventory.sh >>~/$(hostname)-inventory-$(date +%F).log
