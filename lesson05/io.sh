#!/usr/bin/env bash

time $( dd if=/dev/urandom of=/mnt/swapfile55 bs=1M count=2048 )
