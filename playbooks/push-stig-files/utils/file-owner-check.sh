#!/bin/bash
find / -fstype xfs -nouser -print -exec  chown nobody {} \;
find / -fstype xfs -nogroup -print -exec chown :nobody {} \;
