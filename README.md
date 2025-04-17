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
## Auto Config Noez GRE Tunnel
```
bash <(wget -qO- --no-check-certificate https://raw.githubusercontent.com/AKUMAVM/launch/main/gre.sh)
```
