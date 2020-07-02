Filename: one-liner-examples.md  
Author: Trae Elmore  
Description: Examples of ansible one liners for linux administration.  

# Examples of Ansible one liners  
>This is a list of examples of ansible use as your user with ssh keys and sudo access.

#### user management examples  

`ansible boxes -m shell -a "grep someuser /etc/passwd"`  
`ansible boxes -m user -a "name=someuser state=absent remove=yes" -b -K`  

#### package management  
`ansible boxes -m shell -a "subscription-manager refresh" -b -K`  
`ansible boxes -m yum -a "name=flash-player-ppapi state=latest" -b -K`  
`ansible boxes -m yum -a "name=foomatic,hplip state=latest" -b -K`  

#### copying config files to other hosts  
`ansible boxes -m shell -a "mkdir -p /etc/opt/chrome/policies/managed" -b -K`  
`ansible boxes -m copy -a "src=stig.json dest=/etc/opt/chrome/policies/managed/" -b -K`  
`ansible boxes -m copy -a "src=stig.json dest=/etc/opt/chrome/policies/managed/ mode=644" -b -K`  

#### group and user management  
`ansible boxes -m group -a "name=newgroup state=present gid=2002" -b -K`  
`ansible boxes -m user -a "name=olduser state=absent remove=yes" -b -K`  

#### examples of using the shell module for different things  
`ansible somehosts -m shell -a "subscription-manager refresh; yum clean all" -b -K`  
`ansible somehosts -m shell -a "lpadmin -p printer1 -v socket://192.168.X.X:9100 -m foomatic:Generic-PCL_6_PCL_XL_Printer-pxlcolor.ppd -E -L r2190; lpoptions -d r2d2 -o sides=two-sided-long-edge" -b -K`  

#### service management  
`ansible all-linux -m service -a "name=nails state=stopped" -b -K`  
`ansbile lab-box -m service -a "name=httpd state=restarted enabled=yes" -b -K`  

#### firewall management  
`ansible sandbox -m firewalld -a "zone=work service=http permanent=true state=enabled" -b -K`  

#### list failed systems  
`ansible boxes -m shell -a "systemctl list-units --state=failed" -bK`  

