#!/bin/bash

zero_superblock() {
    mdadm --zero-superblock --force /dev/sd[b-c]
}

create_raid() {
    mdadm --create --verbose /dev/md0 --metadata 0.9 -l 0 -n 2 /dev/sd[b-c]
}

save_raid() {
    echo "MAILADDR root" > /etc/mdadm.conf
    bash -c "mdadm --detail --scan >> /etc/mdadm.conf"
}

create_part_raid() {
    parted -s /dev/md0 mklabel gpt
    parted /dev/md0 mkpart primary ext4 0% 100%
    mkfs.ext4 /dev/md0p1
    mkdir -p /backup
    bash -c "echo chmod 777 /backup >> /etc/rc.local"
    echo "/dev/md0p1 /backup ext4 defaults 0 0" >> /etc/fstab
    mount /dev/md0p1 /backup
    chmod -R 777 /backup
}

main() {
    zero_superblock
    create_raid
    save_raid
    create_part_raid
}

[[ "$0" == "$BASH_SOURCE" ]] && main "$@"
