#!/bin/bash

# network on boot?
read -t 1 -n 1000000 discard      # discard previous input
sudo dhcpcd

cd
head -n -5 /etc/X11/xinit/xinitrc > ~/.xinitrc
echo 'exec VBoxClient --clipboard -d &' >> ~/.xinitrc
echo 'exec VBoxClient --display -d &' >> ~/.xinitrc
echo 'export GTK_IM_MODULE=fcitx' >> ~/.xinitrc
echo 'export QT_IM_MODULE=fcitx' >> ~/.xinitrc
echo 'export XMODIFIERS="@im=fcitx"' >> ~/.xinitrc
echo 'exec fcitx &' >> ~/.xinitrc
echo 'exec i3 &' >> ~/.xinitrc
echo 'exec nitrogen --restore &' >> ~/.xinitrc
echo 'exec emacs' >> ~/.xinitrc


#xterm setup
echo 'XTerm*background:black' > ~/.Xdefaults
echo 'XTerm*foreground:white' >> ~/.Xdefaults
echo 'UXTerm*background:black' >> ~/.Xdefaults
echo 'UXTerm*foreground:white' >> ~/.Xdefaults


#i3status
if [ ! -d ~/.config ]; then
    mkdir ~/.config
fi
mkdir ~/.config/i3status
cp /etc/i3status.conf ~/.config/i3status/config
sed -i 's/^order += "ipv6"/#order += "ipv6"/' ~/.config/i3status/config
sed -i 's/^order += "run_watch VPN"/#order += "run_watch VPN"/' ~/.config/i3status/config
sed -i 's/^order += "wireless _first_"/#order += "wireless _first_"/' ~/.config/i3status/config
sed -i 's/^order += "battery 0"/#order += "battery 0"/' ~/.config/i3status/config


# wallpaper setup
cd
if [ -d !"Pictures"]
then
    mkdir Pictures
fi
cd Pictures
wget https://images2.alphacoders.com/601/601091.jpg -O wallpaper.jpg
cd ~/.config/
if [ -d !"nitrogen" ]
 then
     mkdir nitrogen
fi
cd nitrogen
echo '[xin_-1]' > bg-saved.cfg
echo "file=/home/$(whoami)/Pictures/wallpaper.jpg" >> bg-saved.cfg
echo 'mode=0' >> bg-saved.cfg
echo 'bgcolor=#000000' >> bg-saved.cfg
