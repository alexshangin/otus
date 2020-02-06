#!/bin/bash
zero_superblock() {
    mdadm --zero-superblock --force /dev/sd[b-e]
}

create_raid() {
    mdadm --create --verbose /dev/md0 --metadata 0.9 -l 10 -n 4 /dev/sd[b-e]
}

save_raid() {
    echo "MAILADDR root" > /etc/mdadm.conf
    bash -c "mdadm --detail --scan >> /etc/mdadm.conf"
}

create_part_raid() {
    parted -s /dev/md0 mklabel gpt
    parted /dev/md0 mkpart primary ext4 0% 100%
    mkfs.ext4 /dev/md0p1
    mkdir -p /srv
    bash -c "echo chmod 777 /raid10 >> /etc/rc.local"
    echo "/dev/md0p1 /srv ext4 defaults 0 0" >> /etc/fstab
    mount /dev/md0p1 /srv
    chmod -R 777 /srv
}

main() {
    zero_superblock
    create_raid
    save_raid
    create_part_raid
}

[[ "$0" == "$BASH_SOURCE" ]] && main "$@"
