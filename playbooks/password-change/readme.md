## Change a password for a user

use the following to create the hash  
`mkpasswd --method=SHA-512`

use the following to encrypt the valaues file
`ansible-vault encrypt passvalue.yml`

use the following to run the playbook
`ansible-playbook --ask-vault-pass change-user-pass.yml -bK`
