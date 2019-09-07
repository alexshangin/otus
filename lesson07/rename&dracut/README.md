#### Домашняя работа

2. Установить систему с LVM, после чего переименовать VG
3. Добавить модуль в initrd


##### 2. Установить систему с LVM, после чего переименовать VG

  Для установки системы в VirtualBox был использован образ CentOS7.

Проверим диски:
```bash
[root@centos7 ~]# lsblk
NAME                    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda                       8:0    0    8G  0 disk 
├─sda1                    8:1    0    1G  0 part /boot
└─sda2                    8:2    0    7G  0 part 
  ├─centos_centos7-root 253:0    0  6,2G  0 lvm  /
  └─centos_centos7-swap 253:1    0  820M  0 lvm  [SWAP]
sr0                      11:0    1 1024M  0 rom  
```
Проверим группы lvm:
```bash
[root@centos7 ~]# vgs
  VG             #PV #LV #SN Attr   VSize  VFree
  centos_centos7   1   2   0 wz--n- <7,00g    0 
```
Изменим название группы lvm:
```bash
[root@centos7 ~]# vgrename centos_centos7 vg_otus
  Volume group "centos_centos7" successfully renamed to "vg_otus"
```
Изменяем название группы на новое, редактируя слудующие файлы:
```bash
[root@centos7 ~]# vi /etc/fstab 
[root@centos7 ~]# vi /etc/default/grub 
[root@centos7 ~]# vi /boot/grub2/grub.cfg 
```
Пересоздаем initrd:
```bash
[root@centos7 ~]# mkinitrd -f -v /boot/initramfs-$(uname -r).img $(uname -r)
Executing: /usr/sbin/dracut -f -v /boot/initramfs-3.10.0-957.el7.x86_64.img 3.10.0-957.el7.x86_64
dracut module 'modsign' will not be installed, because command 'keyctl' could not be found!
dracut module 'busybox' will not be installed, because command 'busybox' could not be found!
dracut module 'crypt' will not be installed, because command 'cryptsetup' could not be found!
dracut module 'dmraid' will not be installed, because command 'dmraid' could not be found!
dracut module 'dmsquash-live-ntfs' will not be installed, because command 'ntfs-3g' could not be found!
dracut module 'mdraid' will not be installed, because command 'mdadm' could not be found!
dracut module 'multipath' will not be installed, because command 'multipath' could not be found!
dracut module 'cifs' will not be installed, because command 'mount.cifs' could not be found!
dracut module 'iscsi' will not be installed, because command 'iscsistart' could not be found!
dracut module 'iscsi' will not be installed, because command 'iscsi-iname' could not be found!
95nfs: Could not find any command of 'rpcbind portmap'!
dracut module 'modsign' will not be installed, because command 'keyctl' could not be found!
dracut module 'busybox' will not be installed, because command 'busybox' could not be found!
dracut module 'crypt' will not be installed, because command 'cryptsetup' could not be found!
dracut module 'dmraid' will not be installed, because command 'dmraid' could not be found!
dracut module 'dmsquash-live-ntfs' will not be installed, because command 'ntfs-3g' could not be found!
dracut module 'mdraid' will not be installed, because command 'mdadm' could not be found!
dracut module 'multipath' will not be installed, because command 'multipath' could not be found!
dracut module 'cifs' will not be installed, because command 'mount.cifs' could not be found!
dracut module 'iscsi' will not be installed, because command 'iscsistart' could not be found!
dracut module 'iscsi' will not be installed, because command 'iscsi-iname' could not be found!
95nfs: Could not find any command of 'rpcbind portmap'!
*** Including module: bash ***
*** Including module: nss-softokn ***
*** Including module: i18n ***
*** Including module: network ***
*** Including module: ifcfg ***
*** Including module: drm ***
*** Including module: plymouth ***
*** Including module: dm ***
Skipping udev rule: 64-device-mapper.rules
Skipping udev rule: 60-persistent-storage-dm.rules
Skipping udev rule: 55-dm.rules
*** Including module: kernel-modules ***
*** Including module: lvm ***
Skipping udev rule: 64-device-mapper.rules
Skipping udev rule: 56-lvm.rules
Skipping udev rule: 60-persistent-storage-lvm.rules
*** Including module: qemu ***
*** Including module: resume ***
*** Including module: rootfs-block ***
*** Including module: terminfo ***
*** Including module: udev-rules ***
Skipping udev rule: 40-redhat-cpu-hotplug.rules
Skipping udev rule: 91-permissions.rules
*** Including module: biosdevname ***
*** Including module: systemd ***
*** Including module: usrmount ***
*** Including module: base ***
*** Including module: fs-lib ***
*** Including module: microcode_ctl-fw_dir_override ***
  microcode_ctl module: mangling fw_dir
    microcode_ctl: reset fw_dir to "/lib/firmware/updates /lib/firmware"
    microcode_ctl: processing data directory  "/usr/share/microcode_ctl/ucode_with_caveats/intel"...
intel: model '', path ' intel-ucode/*', kvers ''
intel: blacklist ''
    microcode_ctl: intel: Host-Only mode is enabled and "intel-ucode/06-3a-09" matches "intel-ucode/*"
      microcode_ctl: intel: caveats check for kernel version "3.10.0-957.el7.x86_64" passed, adding "/usr/share/microcode_ctl/ucode_with_caveats/intel" to fw_dir variable
    microcode_ctl: processing data directory  "/usr/share/microcode_ctl/ucode_with_caveats/intel-06-4f-01"...
intel-06-4f-01: model 'GenuineIntel 06-4f-01', path ' intel-ucode/06-4f-01', kvers ' 4.17.0 3.10.0-894 3.10.0-862.6.1 3.10.0-693.35.1 3.10.0-514.52.1 3.10.0-327.70.1 2.6.32-754.1.1 2.6.32-573.58.1 2.6.32-504.71.1 2.6.32-431.90.1 2.6.32-358.90.1'
intel-06-4f-01: blacklist ''
intel-06-4f-01: caveat is disabled in configuration
    microcode_ctl: kernel version "3.10.0-957.el7.x86_64" failed early load check for "intel-06-4f-01", skipping
    microcode_ctl: final fw_dir: "/usr/share/microcode_ctl/ucode_with_caveats/intel /lib/firmware/updates /lib/firmware"
*** Including module: shutdown ***
*** Including modules done ***
*** Installing kernel module dependencies and firmware ***
*** Installing kernel module dependencies and firmware done ***
*** Resolving executable dependencies ***
*** Resolving executable dependencies done***
*** Hardlinking files ***
*** Hardlinking files done ***
*** Stripping files ***
*** Stripping files done ***
*** Generating early-microcode cpio image contents ***
*** Constructing GenuineIntel.bin ****
*** Constructing GenuineIntel.bin ****
*** Store current command line parameters ***
*** Creating image file ***
*** Creating microcode section ***
*** Created microcode section ***
*** Creating image file done ***
*** Creating initramfs image file '/boot/initramfs-3.10.0-957.el7.x86_64.img' done ***
```
Перезагружаемся для проверки:
```bash
[root@centos7 ~]# shutdown -r now
```
Проверяем группы:
```bash
[root@centos7 ~]# vgs
  VG      #PV #LV #SN Attr   VSize  VFree
  vg_otus   1   2   0 wz--n- <7,00g    0 
```
Переименование прошло успешно.

##### 3. Добавить модуль в initrd.

Создаем директорию для модуля и переходим в неё:
```bash
[root@centos7 ~]# mkdir /usr/lib/dracut/modules.d/01test
[root@centos7 ~]# cd /usr/lib/dracut/modules.d/01test
```
Создаем файл:
```bash
[root@centos7 01test]# vi module_setup.sh

#------------------------------------------------
#!/bin/bash
 
check() {
     return 0 
} 
depends() {
     return 0 
} 
install() {
     inst_hook cleanup 00 "${moddir}/test.sh" 
} 
#------------------------------------------------
```
Создаем файл:
```bash
[root@centos7 01test]# vi test.sh

#------------------------------------------------
#!/bin/bash 
exec 0<>/dev/console 1<>/dev/console 2<>/dev/console 
cat <<'msgend' 
 ___________________ 
< I'm dracut module > 
 ------------------- 
    \
     \ 
	.--. 
       |o_o | 
       |:_/ | 
      //   \ \ 
     (|     | ) 
    /'\_   _/`\ 
    \___)=(___/ 
msgend 
sleep 10 
echo " continuing....
#------------------------------------------------
```
Пересоздаем initrd:
```bash
[root@centos7 01test]# mkinitrd -f -v /boot/initramfs-$(uname -r).img $(uname -r)
Executing: /usr/sbin/dracut -f -v /boot/initramfs-3.10.0-957.el7.x86_64.img 3.10.0-957.el7.x86_64
dracut module 'modsign' will not be installed, because command 'keyctl' could not be found!
dracut module 'busybox' will not be installed, because command 'busybox' could not be found!
dracut module 'crypt' will not be installed, because command 'cryptsetup' could not be found!
dracut module 'dmraid' will not be installed, because command 'dmraid' could not be found!
dracut module 'dmsquash-live-ntfs' will not be installed, because command 'ntfs-3g' could not be found!
dracut module 'mdraid' will not be installed, because command 'mdadm' could not be found!
dracut module 'multipath' will not be installed, because command 'multipath' could not be found!
dracut module 'cifs' will not be installed, because command 'mount.cifs' could not be found!
dracut module 'iscsi' will not be installed, because command 'iscsistart' could not be found!
dracut module 'iscsi' will not be installed, because command 'iscsi-iname' could not be found!
95nfs: Could not find any command of 'rpcbind portmap'!
dracut module 'modsign' will not be installed, because command 'keyctl' could not be found!
dracut module 'busybox' will not be installed, because command 'busybox' could not be found!
dracut module 'crypt' will not be installed, because command 'cryptsetup' could not be found!
dracut module 'dmraid' will not be installed, because command 'dmraid' could not be found!
dracut module 'dmsquash-live-ntfs' will not be installed, because command 'ntfs-3g' could not be found!
dracut module 'mdraid' will not be installed, because command 'mdadm' could not be found!
dracut module 'multipath' will not be installed, because command 'multipath' could not be found!
dracut module 'cifs' will not be installed, because command 'mount.cifs' could not be found!
dracut module 'iscsi' will not be installed, because command 'iscsistart' could not be found!
dracut module 'iscsi' will not be installed, because command 'iscsi-iname' could not be found!
95nfs: Could not find any command of 'rpcbind portmap'!
*** Including module: bash ***
*** Including module: nss-softokn ***
*** Including module: i18n ***
*** Including module: network ***
*** Including module: ifcfg ***
*** Including module: drm ***
*** Including module: plymouth ***
*** Including module: dm ***
Skipping udev rule: 64-device-mapper.rules
Skipping udev rule: 60-persistent-storage-dm.rules
Skipping udev rule: 55-dm.rules
*** Including module: kernel-modules ***
*** Including module: lvm ***
Skipping udev rule: 64-device-mapper.rules
Skipping udev rule: 56-lvm.rules
Skipping udev rule: 60-persistent-storage-lvm.rules
*** Including module: qemu ***
*** Including module: resume ***
*** Including module: rootfs-block ***
*** Including module: terminfo ***
*** Including module: udev-rules ***
Skipping udev rule: 40-redhat-cpu-hotplug.rules
Skipping udev rule: 91-permissions.rules
*** Including module: biosdevname ***
*** Including module: systemd ***
*** Including module: usrmount ***
*** Including module: base ***
*** Including module: fs-lib ***
*** Including module: microcode_ctl-fw_dir_override ***
  microcode_ctl module: mangling fw_dir
    microcode_ctl: reset fw_dir to "/lib/firmware/updates /lib/firmware"
    microcode_ctl: processing data directory  "/usr/share/microcode_ctl/ucode_with_caveats/intel"...
intel: model '', path ' intel-ucode/*', kvers ''
intel: blacklist ''
    microcode_ctl: intel: Host-Only mode is enabled and "intel-ucode/06-3a-09" matches "intel-ucode/*"
      microcode_ctl: intel: caveats check for kernel version "3.10.0-957.el7.x86_64" passed, adding "/usr/share/microcode_ctl/ucode_with_caveats/intel" to fw_dir variable
    microcode_ctl: processing data directory  "/usr/share/microcode_ctl/ucode_with_caveats/intel-06-4f-01"...
intel-06-4f-01: model 'GenuineIntel 06-4f-01', path ' intel-ucode/06-4f-01', kvers ' 4.17.0 3.10.0-894 3.10.0-862.6.1 3.10.0-693.35.1 3.10.0-514.52.1 3.10.0-327.70.1 2.6.32-754.1.1 2.6.32-573.58.1 2.6.32-504.71.1 2.6.32-431.90.1 2.6.32-358.90.1'
intel-06-4f-01: blacklist ''
intel-06-4f-01: caveat is disabled in configuration
    microcode_ctl: kernel version "3.10.0-957.el7.x86_64" failed early load check for "intel-06-4f-01", skipping
    microcode_ctl: final fw_dir: "/usr/share/microcode_ctl/ucode_with_caveats/intel /lib/firmware/updates /lib/firmware"
*** Including module: shutdown ***
*** Including modules done ***
*** Installing kernel module dependencies and firmware ***
*** Installing kernel module dependencies and firmware done ***
*** Resolving executable dependencies ***
*** Resolving executable dependencies done***
*** Hardlinking files ***
*** Hardlinking files done ***
*** Stripping files ***
*** Stripping files done ***
*** Generating early-microcode cpio image contents ***
*** Constructing GenuineIntel.bin ****
*** Constructing GenuineIntel.bin ****
*** Store current command line parameters ***
*** Creating image file ***
*** Creating microcode section ***
*** Created microcode section ***
*** Creating image file done ***
*** Creating initramfs image file '/boot/initramfs-3.10.0-957.el7.x86_64.img' done ***
```
Проверим, добавился ли наш модуль:
```bash
[root@centos7 01test]# lsinitrd -m /boot/initramfs-$(uname -r).img | grep test
test
```
Удаляем опции **rghb** и **quiet**:
```bash
[root@centos7 01test]# vi /boot/grub2/grub.cfg
```
Перезагружаемся:
```bash
[root@centos7 01test]# shutdown -r now
```