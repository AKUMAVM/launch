#!/bin/bash

# AUTO-CONFIGURE VMBR0 FOR PROXMOX (Auto-detect mode)
# Author: AKUMAVM

# Detect the default route interface
MAIN_IFACE=$(ip route | grep default | awk '{print $5}' | head -n1)

if [ -z "$MAIN_IFACE" ]; then
    echo "Could not detect main interface."
    exit 1
fi

# Detect IP and CIDR
IP_CIDR=$(ip -o -f inet addr show "$MAIN_IFACE" | awk '{print $4}')
IP_ADDRESS=$(echo $IP_CIDR | cut -d/ -f1)
NETMASK=$(echo $IP_CIDR | cut -d/ -f2)

# Detect Gateway
GATEWAY=$(ip route | grep default | awk '{print $3}')

echo "Detected interface: $MAIN_IFACE"
echo "IP address: $IP_ADDRESS/$NETMASK"
echo "Gateway: $GATEWAY"

# Confirm
read -p "Proceed with configuring vmbr0 with these settings? (y/n): " CONFIRM
if [[ "$CONFIRM" != "y" ]]; then
    echo "Cancelled."
    exit 1
fi

# Backup existing interfaces file
cp /etc/network/interfaces /etc/network/interfaces.bak
echo "Backup created at /etc/network/interfaces.bak"

# Generate new interfaces config
cat > /etc/network/interfaces <<EOF
auto lo
iface lo inet loopback

auto $MAIN_IFACE
iface $MAIN_IFACE inet manual

auto vmbr0
iface vmbr0 inet static
    address $IP_ADDRESS/$NETMASK
    gateway $GATEWAY
    bridge-ports $MAIN_IFACE
    bridge-stp off
    bridge-fd 0
EOF

# Restart networking
echo "Restarting networking..."
if systemctl is-active --quiet networking; then
    systemctl restart networking
else
    ifdown vmbr0 && ifup vmbr0
fi

echo "vmbr0 configured using $MAIN_IFACE with IP $IP_ADDRESS"
