#### Generate and Collect SAR information on hosts.  

>This is both a bash script that generates the monthly sar report on each host and an ansible play book that calls the script and then collects the report files to a central web server that runs on the ansible management server.  

>eom-sar.yml is in the /home/$USER/bin/playbooks directory and is called with ansible-playbook via crontab each month.sar-report.sh is copied to /usr/local/bin on each linux host with a mode of 755.  

