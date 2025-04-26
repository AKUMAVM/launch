#!/bin/bash

apt remove linux-image-amd64 'linux-image-6.1*' -y
update-grub
apt remove os-prober -y

echo "Install IP Tables"
apt-get install -y iptables iptables-persistent

echo "Running Post Install PVE script"
bash -c "$(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/tools/pve/post-pve-install.sh)"
