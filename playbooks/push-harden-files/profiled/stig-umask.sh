#!/bin/sh
# Non-Privledged Users get 027
# Privledged Users get 022
if [[ $EUID -ne 0 ]]; then
	umask 027
else
	umask 022
fi
