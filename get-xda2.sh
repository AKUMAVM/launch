#!/bin/sh
# This script detects the primary disk based on the kernel parameters
# Works on Debian, Ubuntu, and RedHat (not for Alpine)

get_all_disks() {
    lsblk -dn -o NAME | grep -Ev '^(loop|sr|nbd)'
}

get_xda() {
    # Ensure the script is run as root
    if [ "$(id -u)" -ne 0 ]; then
        echo "ERROR: This script must be run as root."
        exit 1
    fi

    # Extract the primary disk from kernel parameters
    eval "$(grep -o 'extra_main_disk=[^ ]*' /proc/cmdline | sed 's/^extra_//')"

    if [ -z "$main_disk" ]; then
        echo "ERROR: MAIN_DISK_NOT_FOUND (Kernel parameter not found)"
        exit 1
    fi

    # Loop through all available disks
    for disk in $(get_all_disks); do
        # Use lsblk to match the disk name or serial
        if lsblk -n -o NAME,SERIAL "/dev/$disk" | grep -iq "$main_disk"; then
            echo "$disk"
            return 0
        fi
    done

    echo "ERROR: XDA_NOT_FOUND (Disk not found)"
    exit 1
}

get_xda
