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

#update system time
timedatectl set-ntp true

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

#rank mirrors
echo 'Setting up mirrors'
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
wget https://raw.githubusercontent.com/imxxb/arch-recipes/master/mirrorlist -O /etc/pacman.d/mirrorlist
cp /etc/pacman.d/mirrorlist /mnt/etc/pacman.d/mirrorlist

#pacstrap
pacstrap /mnt base


#fstab
genfstab -U /mnt >> /mnt/etc/fstab

# chroot
wget https://raw.githubusercontent.com/imxxb/arch-recipes/master/chroot-install.sh -O /mnt/chroot-install.sh
arch-chroot /mnt /bin/bash ./chroot-install.sh $user $password

#reboot
umount /mnt/boot
umount /mnt
reboot
