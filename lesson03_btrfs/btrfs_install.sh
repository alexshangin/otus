#!/bin/bash

install_btrfs() {
  yum install -y btrfs-progs
}

create_btrfs() {
  mkfs.btrfs -L data -m raid1 -d raid10 /dev/sd[b-e]
  mkdir -p /data
  bash -c "echo /dev/disk/by-label/data /data btrfs  rw,user,exec 0 0 >> /etc/fstab"
  mount /data
}

create_subvolume() {
  
}

info_btrfs() {
  btrfs filesystem show
  btrfs device usage /data
  btrfs device stats /data
}

replace_faulty() {
  btrfs replace start -f /dev/sde /dev/sdf /data
  btrfs replace status /data
}

scrub_btrfs() {
  btrfs scrub start -B -d /data
}


main() {
  install_btrfs
  create_btrfs
  info_btrfs
}

[[ "$0" == "$BASH_SOURCE" ]] && main "$@"
