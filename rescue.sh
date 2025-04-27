#!/bin/bash

set -e

echo "===== Hetzner Rescue Auto Installer ====="

# Ask user for hostname
read -rp "Enter your desired hostname: " USER_HOSTNAME
if [[ -z "$USER_HOSTNAME" ]]; then
    echo "Hostname cannot be empty!"
    exit 1
fi

# Detect disks
echo "Detecting disks..."
DISKS=($(lsblk -ndo NAME,TYPE | awk '$2=="disk"{print "/dev/"$1}'))
if (( ${#DISKS[@]} < 2 )); then
    echo "Error: Less than two disks detected. Need at least 2 disks for RAID 0."
    exit 1
fi

DRIVE1="${DISKS[0]}"
DRIVE2="${DISKS[1]}"

echo "Disks detected: $DRIVE1 and $DRIVE2"

# Generate .installimage
cat > /root/.installimage <<EOF
# InstallImage
## Basic settings
HOSTNAME $USER_HOSTNAME
IMAGE /root/images/Debian-1208-bookworm-amd64-base.tar.gz
SWRAID 1
SWRAIDLEVEL 0
DRIVE1 $DRIVE1
DRIVE2 $DRIVE2
BOOTLOADER grub

## Partitioning
PART /boot ext4 1024M
PART lvm vg0 all

## LVM Volumes
LV vg0 swap swap swap 64G
LV vg0 root / ext4 all
EOF

echo "Generated /root/.installimage successfully."
chmod +x /root/.installimage
# Start installimage
echo "Starting installation..."
installimage -a -c /root/.installimage
