#!/bin/sh
sudo nixos-generate-config --no-filesystems --root /mnt
sudo mkdir -p /mnt/etc/nixos
cd /mnt/etc/nixos
