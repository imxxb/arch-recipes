# Arch-recipes
This is a set of scripts inspired by [Adrien Brochard abrochard/spartan-arch](https://github.com/abrochard/spartan-arch) designed to automate the creation of a minimal VM running Arch Linux.

## Requirements for Virtual Box VM
- 30GB of space on disk
- 4GB of RAM
- Clipboard sharing in both directions enabled
- Two shared folders org and workspace auto-mount and permanent

## Installation
Boot the VM on archlinux iso and then run the command
```shell
wget https://git.io/fxQrA -O install.sh
bash install.sh [user] [password]
```
