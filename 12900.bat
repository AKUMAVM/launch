@echo off
setlocal EnableDelayedExpansion

:: Check if running as administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process cmd -ArgumentList '/c %~fnx0' -Verb RunAs"
    exit /b
)

:: Change the computer name
wmic computersystem where name="%COMPUTERNAME%" rename "AKUMA-LTSC"
echo Computer name changed to AKUMA-LTSC. A restart is required for the changes to take effect.

:: Set Administrator password
net user Administrator Akuma12345

:: Define the URL for the Intel GPU driver
set "URL=https://downloadmirror.intel.com/849155/gfx_win_101.6647.exe"
set "OUTFILE=%TEMP%\gfx_win_101.6647.exe"

echo Downloading Intel GPU driver...
powershell -ExecutionPolicy Bypass -Command "& {Invoke-WebRequest -Uri '%URL%' -OutFile '%OUTFILE%'}"

if exist "%OUTFILE%" (
    echo Download complete. Installing driver...
    start /wait "" "%OUTFILE%" -s
    echo Installation complete.
) else (
    echo Download failed. Please check the URL or your internet connection.
)

:: Download and run system optimizer
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://install.virtfusion.net/optimize.exe', 'C:\Windows\Temp\optimize.exe')" <NUL
cmd /c C:\Windows\Temp\optimize.exe -v -o -g -windowsupdate disable -storeapp remove-all -antivirus disable
cmd /c C:\Windows\Temp\optimize.exe -f 3 4 5 6 9
del C:\Windows\Temp\optimize.exe

:: Shutdown with 10-second timer
echo The system will shut down in 10 seconds...
shutdown /r /f /t 10

:: Delete script file after execution
del "%~f0"
