#!/bin/bash

user=$1
password=$2


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
echo 'LANG=en_US.UTF-8' > /etc/locale.conf

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

#install administrator's tools
pacman -S --noconfirm dhclient sudo wget

#install virtualbox guest modules
echo 'Installing VB-guest-modules'
pacman -S --noconfirm virtualbox-guest-modules-arch virtualbox-guest-utils

#vbox modules
echo 'vboxsf' > /etc/modules-load.d/vboxsf.conf

#install Xorg
echo 'Installing Xorg'
pacman -S --noconfirm xorg xorg-xinit xterm

#install fonts
pacman -S --noconfirm font-mathematica texlive-core
pacman -S --noconfirm texlive-fontsextra noto-fonts-emoji
pacman -S --noconfirm adobe-source-han-sans-otc-fonts 
pacman -S --noconfirm adobe-source-han-serif-otc-fonts noto-fonts-cjk 
pacman -S --noconfirm wqy-microhei wqy-microhei-lite 
pacman -S --noconfirm adobe-source-han-serif-cn-fonts 
pacman -S --noconfirm adobe-source-han-serif-tw-fonts 
pacman -S --noconfirm adobe-source-han-sans-cn-fonts 
pacman -S --noconfirm adobe-source-han-sans-tw-fonts 
pacman -S --noconfirm wqy-zenhei wqy-bitmapfont 
pacman -S --noconfirm ttf-arphic-ukai ttf-arphic-uming 
pacman -S --noconfirm opendesktop-fonts  ttf-hannom

#install desktop utils 
pacman -S --noconfirm i3 nitrogen lxterminal

#install rake
echo 'Installing development utils'
pacman -S --noconfirm ruby-rake git vim emacs

#set user 
echo 'Setting up user'
read -t 1 -n 1000000 discard      # discard previous input
echo 'root:'$password | chpasswd
useradd -m -G wheel -s /bin/bash $user
echo $user:$password | chpasswd
echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers

#enable services
systemctl enable ntpdate.service

#preparing post install
wget https://raw.githubusercontent.com/imxxb/arch-recipes/master/post-install.sh -O /home/$user/post-install.sh
chown $user:$user /home/$user/post-install.sh
