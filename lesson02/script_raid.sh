#!/bin/bash
#создаем raid10

#зануляем суперблок на случай, если диски уже использовались
zero_superblock() {
    mdadm --zero-superblock --force /dev/sd[b-f]
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
    parted /dev/md0 mkpart primary ext4 0% 20%
    parted /dev/md0 mkpart primary ext4 20% 40%
    parted /dev/md0 mkpart primary ext4 40% 60%
    parted /dev/md0 mkpart primary ext4 60% 80%
    parted /dev/md0 mkpart primary ext4 80% 100%
    #создаем фс на партициях
    for i in $(seq 1 5); do mkfs.ext4 /dev/md0p$i; done
    #создаем каталоги для монтирования
    mkdir -p /raid10/part{1,2,3,4,5}
    #изменяем права
    chmod -R 660 /raid10
    #монтируем 
    for i in $(seq 1 5); do mount /dev/md0p$i /raid10/part$i; done
    #добавляем в fstab
    echo "/dev/md0p1 /raid10/part1 ext4 defaults 0 0" >> /etc/fstab
    echo "/dev/md0p2 /raid10/part2 ext4 defaults 0 0" >> /etc/fstab
    echo "/dev/md0p3 /raid10/part3 ext4 defaults 0 0" >> /etc/fstab
    echo "/dev/md0p4 /raid10/part4 ext4 defaults 0 0" >> /etc/fstab
    echo "/dev/md0p5 /raid10/part5 ext4 defaults 0 0" >> /etc/fstab
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
    check_raid
    save_raid
    create_part_raid
    view_raid
}


[[ "$0" == "$BASH_SOURCE" ]] && main "$@"
