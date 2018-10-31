#!/bin/bash

# network on boot?
read -t 1 -n 1000000 discard      # discard previous input
sudo dhcpcd

cd
head -n -5 /etc/X11/xinit/xinitrc > ~/.xinitrc
# echo 'exec VBoxClient --clipboard -d &' >> ~/.xinitrc
# echo 'exec VBoxClient --display -d &' >> ~/.xinitrc
echo 'exec i3 &' >> ~/.xinitrc
echo 'exec nitrogen --restore &' >> ~/.xinitrc
echo 'exec emacs' >> ~/.xinitrc


#xterm setup
echo 'XTerm*background:black' > ~/.Xdefaults
echo 'XTerm*foreground:white' >> ~/.Xdefaults
echo 'UXTerm*background:black' >> ~/.Xdefaults
echo 'UXTerm*foreground:white' >> ~/.Xdefaults
