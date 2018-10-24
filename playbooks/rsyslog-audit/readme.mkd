To setup a new rsyslog client please work through the following process.  
Host, user, fqdn and ip addresses have all been made generic through all these files. Please adjust for your usage.

1. Create a client TLS cert and key using 
  `syslog1:/home/user/rsyslog-certs/configsetup.sh`

  If rsclient-cert.pem and /or rslclient-key.pem are already present, toss them
  first

2. Copy syslog1:/home/user/rsyslog-certs/ca-cert.pem and the newly generated
   rsclient-cert.pem and rslclient-key.pem to the target host at
   `/etc/pki/rsyslog'

3. Ensure the files have the following file system permissions:

    -rw-r-----. 1 root root 1554 Jun 19 14:51 ca-cert.pem
    -rw-r-----. 1 root root 1684 Jun 19 15:06 rslclient-cert.pem
    -rw-------. 1 root root 5826 Jun 19 15:02 rslclient-key.pem

4. Run `restorecon -Rv /etc/pki/rsyslog/` on the target host.

5. From an ansible management node, run the 'setup-rsyslog-client.yml' playbook
   on the target host.
 
CLIENT CERTIFICATE CREATION:
On syslog1, a client tls certificate and key will need generated. Please use the configsetup.sh script in /home/user/rsyslog-certs. Its usage is documented in the shell script comments at the top of the file. All you need should be contained in that directory. If you find an rslclient-cert.pem and an rslclient-key.pem file already present in the directory, please delete them first.
The client.cfg file is a template certificate file that is updated by the configsetup.sh. It allows for non-interactive certificate creation.

CLIENT SIDE SETUP
Once the certificates are created they need moved to the client system. Copy the ca-cert.pem, the rslclient-cert.pem and the rslclient-key.pem files to the /etc/pki/rsyslog directory on the client system.
-rw-r-----. 1 root root 1554 Jun 19 14:51 ca-cert.pem
-rw-r-----. 1 root root 1684 Jun 19 15:06 rslclient-cert.pem
-rw-------. 1 root root 5826 Jun 19 15:02 rslclient-key.pem
All 3 files should be owned by root with permissions as noted by above. Run a restorecon -Rv /etc/pki/rsyslog/ afterwards as well.
Once the certificate files are in place the rest of the client side setup is completed with the setup-rsyslog-client.yml playbook from an ansible management node. Please update your playbook with the proper ansible hostname.
