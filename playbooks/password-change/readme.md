## Change a password for a user

On debian based sysetms use the following to create the hash:  
`mkpasswd --method=SHA-512`

Or use the following if that is not available:  
`python3 -c 'import crypt; print(crypt.crypt("test", crypt.mksalt(crypt.METHOD_SHA512)))'`

use the following to encrypt the valaues file
`ansible-vault encrypt passvalue.yml`

use the following to run the playbook
`ansible-playbook --ask-vault-pass change-user-pass.yml -bK`
