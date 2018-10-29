#!/bin/bash

if [ -z "$1" ]
then
    echo "Enter your username: "
    read user
else
    user=$1
fi

if [ -z "$2" ]
then
    echo "Enter your master password: "
    read -s password
else
    password=$2
fi

#partiton disk
parted --script /dev/sda mklabel msdos
parted --script /dev/sda mkpart primary ext4 0% 512M 
parted --script /dev/sda mkpart primary ext4 512M 87% 
parted --script /dev/sda mkpart primary linux-swap 87% 100%

mkfs.ext4 /dev/sda1
mkfs.ext4 /dev/sda2
mkswap /dev/sda3
swapon /dev/sda3
mount /dev/sda2 /mnt
mkdir -p /mnt/boot
mount /dev/sda1 /mnt/boot
