@echo off
:: Prompt for new RDP port
set /p NEWPORT=Enter new RDP port (e.g. 12345):

:: Change the RDP port in the registry
reg add "HKLM\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v PortNumber /t REG_DWORD /d %NEWPORT% /f

:: Add new firewall rule for the custom port
netsh advfirewall firewall add rule name="RDP Custom Port %NEWPORT%" dir=in action=allow protocol=TCP localport=%NEWPORT%

:: Restart Remote Desktop Services
echo Restarting Remote Desktop Services...
net stop termservice
net start termservice

echo.
echo Done!
pause
