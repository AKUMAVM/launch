@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

:: Configuration URL
set confhome=https://raw.githubusercontent.com/AKUMAVM/launch/main

:: Ensure script is run as Administrator
fltmc >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Please run this script as Administrator!
    exit /b
)

:: Change to the script directory
if "%~dp0" neq "" cd /d "%~dp0"

:: Ensure temporary directory exists
if not exist "%tmp%" md "%tmp%"

:: Check if `curl` is available
where curl >nul 2>nul
if errorlevel 1 (
    echo [INFO] curl not found, using alternative methods.
    set "use_curl=0"
) else (
    set "use_curl=1"
)

:: Function to download files
:download
echo [INFO] Downloading: %~1 -> %~2
del /q "%~2" 2>nul

if exist "%~2" (
    echo [ERROR] Failed to delete old file: %~2
    exit /b 1
)

if %use_curl%==1 (
    curl -L --retry 3 --retry-delay 5 "%~1" -o "%~2"
) else (
    bitsadmin /transfer "Download" "%~1" "%~2" >nul 2>nul
    if errorlevel 1 certutil -urlcache -split "%~1" "%~2" >nul
)

if not exist "%~2" (
    echo [ERROR] Download failed: %~1
    exit /b 1
)

exit /b 0

:: Download mark.sh if it does not exist
if not exist "mark.sh" (
    call :download "%confhome%/mark.sh" "%~dp0mark.sh"
    if errorlevel 1 (
        echo [ERROR] Failed to download mark.sh
        exit /b 1
    )
)

:: Ensure mark.sh is executable if using Bash
where bash >nul 2>nul
if not errorlevel 1 (
    bash -c "chmod +x mark.sh"
)

:: Check if Bash is available before running the script
where bash >nul 2>nul
if errorlevel 1 (
    echo [ERROR] Bash not found! Ensure Cygwin or Git Bash is installed.
    exit /b 1
)

:: Run mark.sh using Bash
bash mark.sh %*
exit /b 0
