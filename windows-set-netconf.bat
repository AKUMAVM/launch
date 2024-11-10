rem set mac_addr=11:22:33:aa:bb:cc

rem set ipv4_addr=192.168.1.2/24
rem set ipv4_gateway=192.168.1.1
rem set ipv4_dns1=192.168.1.1
rem set ipv4_dns2=192.168.1.2

rem set ipv6_addr=2222::2/64
rem set ipv6_gateway=2222::1
rem set ipv6_dns1=::1
rem set ipv6_dns2=::2

@echo off
mode con cp select=437 >nul
setlocal EnableDelayedExpansion

rem 禁用 IPv6 地址标识符的随机化，防止 IPv6 和后台面板不一致
netsh interface ipv6 set global randomizeidentifiers=disabled

rem 检查是否定义了 MAC 地址
if defined mac_addr (
    for /f %%a in ('wmic nic where "MACAddress='%mac_addr%'" get InterfaceIndex ^| findstr [0-9]') do set id=%%a
    if defined id (
        rem 配置静态 IPv4 地址和网关
        if defined ipv4_addr if defined ipv4_gateway (
        rem gwmetric 默认值为 1，自动跃点需设为 0
            netsh interface ipv4 set address !id! static !ipv4_addr! gateway=!ipv4_gateway! gwmetric=0
        )

        rem 配置静态 IPv4 DNS 服务器
        for %%i in (1, 2) do (
            if defined ipv4_dns%%i (
                netsh interface ipv4 add | findstr "dnsservers"
                if ErrorLevel 1 (
                    rem vista
                    netsh interface ipv4 add dnsserver !id! !ipv4_dns%%i! %%i
                ) else (
                    rem win7
                    netsh interface ipv4 add dnsservers !id! !ipv4_dns%%i! %%i no
                )
            )
        )

        rem 配置 IPv6 地址和网关
        if defined ipv6_addr if defined ipv6_gateway (
            netsh interface ipv6 set address !id! !ipv6_addr!
            netsh interface ipv6 add route prefix=::/0 !id! !ipv6_gateway!
        )

        rem 配置 IPv6 DNS 服务器
        for %%i in (1, 2) do (
            if defined ipv6_dns%%i (
                netsh interface ipv6 add | findstr "dnsservers"
                if ErrorLevel 1 (
                    rem vista
                    netsh interface ipv6 add dnsserver !id! !ipv6_dns%%i! %%i
                ) else (
                    rem win7
                    netsh interface ipv6 add dnsservers !id! !ipv6_dns%%i! %%i no
                )
            )
        )
    )
)

REM Downloading Optimize Apps
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://install.virtfusion.net/optimize.exe', 'C:\Windows\Temp\optimize.exe')" <NUL
cmd /c C:\Windows\Temp\optimize.exe -v -o -g -windowsupdate disable -storeapp remove-all -antivirus disable
cmd /c C:\Windows\Temp\optimize.exe -f 3 4 5 6 9
del C:\Windows\Temp\optimize.exe

REM Downloading Qemu Agent
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.262-2/virtio-win-guest-tools.exe', 'C:\Windows\Temp\virtio-win-guest-tools.exe')" <NUL
cmd /c C:\Windows\Temp\virtio-win-guest-tools.exe /quiet /norestart
del C:\Windows\Temp\virtio-win-guest-tools.exe

REM Check for OneDrive setup executable path
set onedrive=%SystemRoot%\SysWOW64\OneDriveSetup.exe
if not exist "%onedrive%" (
    set onedrive=%SystemRoot%\System32\OneDriveSetup.exe
)

REM Stop OneDrive processes
taskkill /F /IM OneDrive.exe /T
timeout /t 2 > nul

REM Uninstall OneDrive
"%onedrive%" /uninstall
timeout /t 2 > nul

REM Remove leftover OneDrive files
rmdir "%USERPROFILE%\OneDrive" /S /Q
rmdir "%LOCALAPPDATA%\Microsoft\OneDrive" /S /Q
rmdir "%PROGRAMDATA%\Microsoft OneDrive" /S /Q
if exist "%SYSTEMDRIVE%\OneDriveTemp" (
    rmdir "%SYSTEMDRIVE%\OneDriveTemp" /S /Q
)

REM Cleanup Profile Usage Information
for /d %%D in ("C:\Users\Administrator\AppData\Local\Temp\*") do rd /s /q "%%D"
del /q /f "C:\Users\Administrator\AppData\Local\Temp\*"
for /d %%D in ("C:\Users\Administrator\AppData\Roaming\Microsoft\Windows\Recent\*") do rd /s /q "%%D"
del /q /f "C:\Users\Administrator\AppData\Roaming\Microsoft\Windows\Recent\*"
for /d %%D in ("C:\Users\Administrator\Downloads\*") do rd /s /q "%%D"
del /q /f "C:\Users\Administrator\Downloads\*"
del /q /f "C:\Windows\System32\sysprep\Panther\setupact.log"
del /q /f "C:\Windows\System32\sysprep\Panther\setuperr.log"
del /q /f "C:\Windows\System32\sysprep\Panther\IE\setupact.log"

REM Removes Temporary Files
for /d %%D in ("C:\Windows\Temp\*") do rd /s /q "%%D"
del /q /f "C:\Windows\Temp\*"

REM Clears Explorer Run History
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" /f >nul 2>&1

REM Removes any previous Memory Dump files
del /q /f "C:\Windows\*.DMP"
for /d %%D in ("C:\Windows\Minidump") do rd /s /q "%%D"

REM Clearing Event Logs
wevtutil cl Application
wevtutil cl System
wevtutil cl Security

REM Set the account lockout threshold to 0 (disabled)
net accounts /lockoutthreshold:0

REM Confirm the setting
net accounts | find /i "Lockout threshold"

rem Delete script file
del "%~f0"
