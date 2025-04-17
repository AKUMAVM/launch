#!/bin/bash

# Detect an IP from gre10 interface
GRE_IP=$(ip -4 addr show gre10 | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | head -n1)

if [[ -z "$GRE_IP" ]]; then
  echo "No IPv4 address found on gre10. Is the interface up and configured?"
  exit 1
fi

echo "Detected GRE IP on gre10: $GRE_IP"

# Extract base IP for vmbr1 using first three octets of the GRE IP
IP_PREFIX=$(echo $GRE_IP | cut -d'.' -f1-3)
LAST_OCTET=$(echo $GRE_IP | cut -d'.' -f4)
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
