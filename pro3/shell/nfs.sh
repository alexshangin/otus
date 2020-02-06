#!/bin/bash
#создаем raid10

#зануляем суперблок на случай, если диски уже использовались
zero_superblock() {
    mdadm --zero-superblock --force /dev/sd[b-e]
}

#создаем массив
create_raid() {
    mdadm --create --verbose /dev/md0 --metadata 0.9 -l 10 -n 4 /dev/sd[b-e]
}

#проверяем массив
check_raid() {
    cat /proc/mdstat
}

#сохраняем конфиг массива
save_raid() {
    echo "MAILADDR root" > /etc/mdadm.conf
    bash -c "mdadm --detail --scan >> /etc/mdadm.conf"
}

create_part_raid() {
    #создаем раздел gpt
    parted -s /dev/md0 mklabel gpt
    #добавляем партиции в массив
    parted /dev/md0 mkpart primary ext4 0% 100%
    #создаем фс на партициях
    mkfs.ext4 /dev/md0p1
    #создаем каталоги для монтирования
    mkdir -p /raid10
    bash -c "echo chmod 777 /raid10 >> /etc/rc.local"
    #добавляем в fstab
    echo "/dev/md0p1 /raid10 ext4 defaults 0 0" >> /etc/fstab
    #монтируем 
    mount /dev/md0p1 /raid10
    #изменяем права
    chmod -R 777 /raid10
}

view_raid() {
    #смотрим примонтированные размеры и разделы
    df -h | grep md0p
    mdadm --detail /dev/md0
}

test_fail_raid() {
    #сломаем и починим рейд
    #помечаем диск как неисправный
    mdadm /dev/md0 --fail /dev/sde
    #удаляем неисправный диск из массива
    mdadm /dev/md0 --remove /dev/sde
    #добавляем в массив новый диск
    mdadm /dev/md0 --add /dev/sdf
    #смотрим прогресс ребилда рейда
    cat /proc/mdstat
}

main() {
    zero_superblock
    create_raid
    save_raid
    create_part_raid
}


[[ "$0" == "$BASH_SOURCE" ]] && main "$@"
