#!/bin/bash

user=$1
password=$2

#rank mirrors
echo 'Setting up mirrors'
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup
rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist

#setup timezone
echo 'Setting up timezone'
timedatectl set-ntp true
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
timedatectl set-timezone Asia/Shanghai
hwclock --systohc

#setup locale
echo 'Setting up locale'
sed -i 's/^#zh_CN.UTF-8/zh_CN.UTF-8/' /etc/locale.gen
locale-gen
echo 'LANG=zh_CN.UTF-8' > /etc/locale.conf

#setup hostname
echo 'Setting up hostname'
echo 'arch-vbox' > /etc/hostname

#initramfs
mkinitcpio -p linux

#install bootloader
echo 'Installing bootloader'
pacman -S --noconfirm grub
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

#install rake
pacman -S --noconfirm ruby-rake
