Работа с mdadm.

Цель:

Системный администратор обязан уметь работать дисковой подсистемой,
делать это без ошибок, не допускать потерю данных. В этом задании 
необходимо продемонстрировать умение работать с software raid и
инструментами для работы с работы с разделами(parted,fdisk,lsblk):
-добавить в Vagrantfile еще дисков
-сломать/починить raid
-собрать R0/R5/R10 - на выбор
-создать на рейде GPT раздел и 5 партиций

в качестве проверки принимаются:
-измененный Vagrantfile
-скрипт для создания рейда

* доп. задание - Vagrantfile, который сразу собирает систему с подключенным рейдом

**перенесети работающую систему с одним диском на RAID 1. Даунтайм на загрузку с
 нового диска предполагается. В качестве проверики принимается вывод команды lsblk
 до и после и описание хода решения (можно воспользовать утилитой Script).

Домашняя работа 2. Цель - Миграция живой системы на RAID1

Vagrantfile - конфигурационный файл
lsblk1 - вывод команды до переноса на массив
lsblk2 - вывод после переноса

===================================

Краткая инструкция по переносу:

Перенос рабочей системы CentOS 7 на raid1.

Имеем рабочую систему / на разделе /dev/sda1, без файла подкчачки и отдельного раздела под /boot.
Текущий раздел имее файловую систему xfs без использования lvm.
Добавляем второй диск /dev/sdb в систему, такого же либо большего размера.
Устанавливаем mdadm, если его нет в системе:
yum install -y mdadm

Подготовка диска.
Сделаем идентичную схему разделов как у /dev/sda:
sfdisk -d /dev/sda | sfdisk -f /dev/sdb

Проверим разделы на дисках:
fdisk -l

Изменим метку нового диска /dev/sdb на "Linux raid autodetect":
fdisk /dev/sdb
"t"
"fd"
"w"

Создадим raid 1 в деградации:
mdadm --create /dev/md0 --metadata=0.90 --level=1 --raid-devices=2 missing /dev/sdb1

Проверим созданный массив:
cat /proc/mdstat

Создадим файловую систему на raid 1:
mkfs.xfs /dev/md0

Перенос данных.
Монтируем диск:
mount /dev/md0 /mnt/

Копируем данные:
rsync -auxHAXSv --exclude=/dev/* --exclude=/proc/* --exclude=/sys/* --exclude=/tmp/* --exclude=/mnt/*  /* /mnt
rsync -auxHAXSv /boot/* /mnt

Монтируем системные пути:
mount --bind /proc /mnt/proc && mount --bind /dev /mnt/dev && mount --bind /sys /mnt/sys && mount --bind /run /mnt/run

Меняем юзера на chroot:
chroot /mnt/

!На данном этапе все действия от пользователя chroot!

Изменим fstab с использованием нового UUID.
Проверим наш UUID:
blkid /dev/md*
/dev/md0: UUID="916c983f-f775-430a-9ed4-0b2b7dc46551" TYPE="xfs" 

Иземняем UUID старого раздела / на наш новый UUID:
vi /etc/fstab
UUID=916c983f-f775-430a-9ed4-0b2b7dc46551 /                       xfs     defaults        0 0

Создаём конфигурацию mdadm:
mdadm --detail --scan > /etc/mdadm.conf

Подготовка initramfs.
Сделаем резервную копию initramfs:
mv /boot/initramfs-3.10.0-957.12.2.el7.x86_64.img /boot/initramfs-3.10.0-957.12.2.el7.x86_64.img.bak

Заново создадим initramfs:
dracut --mdadmconf --fstab --add="mdraid" --filesystems "xfs ext4 ext3 tmpfs devpts sysfs proc" --add-drivers="raid1" --force /boot/initramfs-$(uname -r).img $(uname -r) -M

Изменяем grub.
Добавим несколько default параметров к grub:
vi /etc/default/grub
GRUB_CMDLINE_LINUX="rd.auto rd.auto=1 rhgb quiet"
GRUB_PRELOAD_MODULES="mdraid1x"

Сделаем новый конфиг grub:
grub2-mkconfig -o /boot/grub2/grub.cfg

Установка grub.
Устанавливаем grub на новый диск /dev/sdb:
grub2-install /dev/sdb

Делаем выход из chroot.

Перезагружаем систему и выбираем для загрузки наш новый диск /dev/sdb.

Проверим диски:
lsblk
-------------------------------------------
NAME    MAJ:MIN RM SIZE RO TYPE  MOUNTPOINT
sda       8:0    0  40G  0 disk  
`-sda1    8:1    0  40G  0 part  
sdb       8:16   0  41G  0 disk  
`-sdb1    8:17   0  40G  0 part  
  `-md0   9:0    0  40G  0 raid1 /
-------------------------------------------

Массив должен быть смонтирован в /

Изменим метку старого диска /dev/sda на "Linux raid autodetect":
fdisk /dev/sdb
"t"
"fd"
"w"

Добавим /dev/sda к массиву:
mdadm --manage /dev/md0 --add /dev/sda1

Смотрим как делается ребилд массива:
watch -n1 "cat /proc/mdstat"

Устанавливаем grub на /dev/sda:
grub2-install /dev/sda

Проверим массив:
cat /proc/mdstat

Перезагружаем систему в обычном режиме, выбрав для загрузки первый диск:
reboot

Проверяем диски:
lsblk
-------------------------------------------
NAME    MAJ:MIN RM SIZE RO TYPE  MOUNTPOINT
sda       8:0    0  40G  0 disk  
`-sda1    8:1    0  40G  0 part  
  `-md0   9:0    0  40G  0 raid1 /
sdb       8:16   0  41G  0 disk  
`-sdb1    8:17   0  40G  0 part  
  `-md0   9:0    0  40G  0 raid1 /
-------------------------------------------

Использованные источники:
Официальная документыция mdadm
google :)
https://habr.com/ru/post/248073/
https://cmatthew.net/wiki/Convert_to_raid_1_CentOS_7