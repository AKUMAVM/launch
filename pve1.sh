#!/bin/bash

set -e

echo "[+] Updating system..."
apt update && apt upgrade -y

echo "Install and Setup pre-run script"
apt install -y wget curl nano screen ftp linux-cpupower

echo "Configures CPU freqs"
cpupower frequency-set --governor performance
cpupower idle-set --disable-by-latency 0

echo "[+] Adding Proxmox VE repository..."
echo "deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription" > /etc/apt/sources.list.d/pve-install.list

wget -qO- https://enterprise.proxmox.com/debian/proxmox-release-bookworm.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/proxmox-release-bookworm.gpg

echo "[+] Updating apt sources..."
apt update && apt full-upgrade -y

echo "[+] Installing Proxmox VE packages..."
apt install -y proxmox-ve postfix open-iscsi

reboot now
