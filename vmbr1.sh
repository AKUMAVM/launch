#!/bin/bash

# Prompt for IP (will use $ip.1/32)
read -p "Enter base IP for vmbr1 (e.g. 5.230.118.224): " BASE_IP

# Extract subnet base (remove last octet)
IP_PREFIX=$(echo $BASE_IP | cut -d'.' -f1-3)
LAST_OCTET=$(echo $BASE_IP | cut -d'.' -f4)
BRIDGE_IP="${IP_PREFIX}.${LAST_OCTET}.1"

# Backup current interfaces file
cp /etc/network/interfaces /etc/network/interfaces.bak.$(date +%F-%H%M)

# Append vmbr1 config to interfaces file
cat <<EOF >> /etc/network/interfaces

auto vmbr1
iface vmbr1 inet static
    address ${BRIDGE_IP}/32
    bridge-ports none
    bridge-stp off
    bridge-fd 0
    mtu 1476
    post-up /root/gre.sh
EOF

echo "vmbr1 configuration added to /etc/network/interfaces."

ifreload -a
echo "Network changes succesfully applied!"
