#!/bin/bash
export KERN_DIR="/usr/src/kernels/3.10.0-229.4.2.el7.x86_64/"
mkdir /media/VBoxGuestAdditions
mount -o loop,ro *.iso /media/VBoxGuestAdditions
sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
umount /media/VBoxGuestAdditions
