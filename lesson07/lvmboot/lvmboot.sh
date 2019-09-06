#!/usr/bin/env bash

updategrub(){
printf "[grublvm]\nname=grublvm\nbaseurl=https://yum.rumyantsev.com/centos/7/x86_64/\ngpgcheck=0\nenabled=1\n" >> /etc/yum.repos.d/grub.repo
yum -y update grub2
}

createlvm(){
pvcreate --bootloaderareasize 1m /dev/sdb
vgcreate VolGroup01 /dev/sdb
lvcreate -L 1G VolGroup01 -n swap
lvcreate -l+100%FREE VolGroup01 -n root
mkfs.ext4 /dev/VolGroup01/root
mkswap /dev/VolGroup01/swap
}

copydata(){
mount /dev/VolGroup01/root /mnt
rsync -aHAX --exclude=/dev/* --exclude=/proc/* --exclude=/sys/* --exclude=/tmp/* --exclude=/mnt/* /* /mnt
mount --bind /proc /mnt/proc && mount --bind /dev /mnt/dev && mount --bind /sys /mnt/sys && mount --bind /run /mnt/run
}

updateinitram(){
chroot /mnt/ /bin/bash -c "echo /dev/mapper/VolGroup01-root / ext4  defaults 0 0 > /etc/fstab && \
echo /dev/mapper/VolGroup01-swap swap swap defaults 0 0 >> /etc/fstab && \
sed -i 's/GRUB_CMDLINE_LINUX/#GRUB_CMDLINE_LINUX/g' /etc/default/grub && \
echo 'GRUB_CMDLINE_LINUX=\"no_timer_check console=tty0 console=ttyS0,115200n8 net.ifnames=0 biosdevname=0 crashkernel=auto rd.lvm.lv=VolGroup01/root rd.lvm.lv=VolGroup01/swap selinux=0\"' >> /etc/default/grub && \
dracut -f && \
grub2-install /dev/sdb && \
grub2-mkconfig -o /boot/grub2/grub.cfg && \
exit"
}

rebootvm(){
shutdown -r now
}

main(){
updategrub
createlvm
copydata
updateinitram
rebootvm
}

[[ "$0" == "$BASH_SOURCE" ]] && main "$@"