#! /usr/bin/env bash
sudo yum install -y mc wget gcc bison flex bc elfutils-libelf-devel openssl-devel ncurces-devel
sudo wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.19.61.tar.xz
sudo tar -xvf linux-4.19.61.tar.xz -C /usr/src
sudo cp /boot/config* /usr/src/linux-4.19.61/.config
cd /usr/src
sudo ln -s linux-4.19.61 linux
cd linux
sudo yes "" | sudo make oldconfig
sudo make
sudo make modules_install
sudo make install
sudo make headers_install
sudo cat /boot/grub2/grub.cfg | sudo grep 4.1
sudo grub2-set-default 0
