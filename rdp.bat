@echo off
:: Prompt for new RDP port
set /p NEWPORT=Enter new RDP port (e.g. 12345):

:: Validate port (basic check for digits only)
echo %NEWPORT% | findstr /R "^[0-9][0-9]*$" >nul
if %errorlevel% neq 0 (
    echo Invalid input. Please enter a numeric port.
    pause
    exit /b
)

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
#echo You can now connect using: your-server-ip:%NEWPORT%
pause
