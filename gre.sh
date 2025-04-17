#!/bin/bash

DEFAULT_IFACE=$(ip route get 1 | awk '{print $5; exit}')
LOCAL_IP=$(ip addr show "$DEFAULT_IFACE" | grep -w inet | awk '{print $2}' | cut -d'/' -f1 | head -n1)
read -p "Enter remote IP (other side): " REMOTE_IP
read -p "Enter GRE interface name (default: gre10): " GRE_IF
GRE_IF=${GRE_IF:-gre10}

read -p "Enter internal IP for this GRE (e.g., 172.28.215.190/30): " GRE_LOCAL_IP
read -p "Enter GRE peer IP (gateway, e.g., 172.28.215.189): " GRE_PEER_IP

read -p "Enter routing table number (default: 20): " ROUTING_TABLE
ROUTING_TABLE=${ROUTING_TABLE:-20}

read -p "Enter interface connected to the source IPs (default: vmbr1): " BRIDGE_IF
BRIDGE_IF=${BRIDGE_IF:-vmbr1}

read -p "Enter MTU size (default: 1476): " MTU_SIZE
MTU_SIZE=${MTU_SIZE:-1476}

echo "Enter source IPs for 'ip rule' (space-separated, e.g. 5.230.118.224 5.230.118.225):"
read -a SOURCE_IPS

cat <<EOF > /root/gre.sh
#!/bin/bash
# Create GRE tunnel
ip tunnel add $GRE_IF mode gre local $LOCAL_IP remote $REMOTE_IP ttl 255
ip addr add $GRE_LOCAL_IP dev $GRE_IF
ip link set $GRE_IF up

# Add ip rules and routes
for IP in ${SOURCE_IPS[@]}; do
  ip rule add from \$IP table $ROUTING_TABLE
  ip route add \$IP dev $BRIDGE_IF
done

# Add default route to custom table
ip route add default via $GRE_PEER_IP dev $GRE_IF table $ROUTING_TABLE

# Set MTU
ip link set $GRE_IF mtu $MTU_SIZE
ip link set $BRIDGE_IF mtu $MTU_SIZE
EOF

chmod +x /root/gre.sh
bash /root/gre.sh
echo "GRE tunnel $GRE_IF has been save to root directory and set up successfully!"


