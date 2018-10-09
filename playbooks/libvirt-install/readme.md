### create a libvirt kvm vm

> pass the ansible play the variables vm_name and vm_os with the -e arguement. vm_os should either be centos or fedora. Assumptions are that you have in /var/lib/libvirt/images/isos a f28server.iso and a c7server.iso. Likewise, it is assumed you have a c7server.cfg kickstart file and a fserver.cfg fedora kickstart file.
