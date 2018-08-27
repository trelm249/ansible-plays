###Create a VCenter VM  

>This playbook is run from an ansible management workstation that has pip and pyvmomi installed to take advantage of the vmware_guest ansible module. For RHEL7 Workstation pip is available from epel.  

>You will pass your vcenter account name, its password, and the name of the new virtual machine as command line variables to the playbook. The playbook will create a virtual machine from an existing template that has no OS actually installed. The virtual machine will power on and PXE boot from your kickstart server.

`ansible-playbook buildvm.yml -e 'admin_user=myvcenterusername' -e 'admin_pass=secretpassword' -e 'vm_name=someVM' -bK`
