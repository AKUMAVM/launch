## Usages
## Linux
```
bash <(wget -qO- --no-check-certificate https://raw.githubusercontent.com/AKUMAVM/launch/main/kernel.sh)
```
## Windows (PowerShell)
```
certutil -urlcache -f -split https://raw.githubusercontent.com/AKUMAVM/launch/main/mark.bat
```
## PVE Auto Config Network
```
bash <(wget -qO- --no-check-certificate https://raw.githubusercontent.com/AKUMAVM/launch/main/vmbr0.sh)
```
```
bash <(wget -qO- --no-check-certificate https://raw.githubusercontent.com/AKUMAVM/launch/main/vmbr1.sh)
```
## Auto config GRE Tunnel
```
curl -sL https://raw.githubusercontent.com/AKUMAVM/launch/main/gre.sh -o /root/gre.sh && chmod +x /root/gre.sh && bash /root/gre.sh
```
