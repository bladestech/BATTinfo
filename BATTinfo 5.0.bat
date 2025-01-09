@echo off
title BATTinfo

color 9F

echo  oooooooooooooooooooooooooooooooooooooooooooooooooooooo
echo  o ####    ###  ###### ###### ###  #   #   ####  ###  o
echo  o #   #  #   #   ##     ##    #   ##  #  #     #   # o
echo  o ####   #####   ##     ##    #   # # #  ###   #   # o
echo  o #   #  #   #   ##     ##    #   #  ##  #     #   # o
echo  o ####   #   #   ##     ##   ###  #   #  #      ###  o
echo  oooooooooooooooooooooooooooooooooooooooooooooooooooooo
echo.

setlocal EnableDelayedExpansion

>nul 2>&1 net session
if %errorLevel% neq 0 (
    echo This software requires admin privileges for accurate results. Please run as administrator.
    pause
    goto :eof
)

for /f "tokens=2 delims==" %%I in ('wmic path Win32_Battery get BatteryStatus /value') do (
    set BatteryStatus=%%I
)

if "%BatteryStatus%" equ "2" (
    set BatteryStatus=Charging
) else if "%BatteryStatus%" equ "1" (
    set BatteryStatus=Discharging
) else (
    set BatteryStatus=Unknown
)

for /f "tokens=2 delims==" %%I in ('wmic path Win32_Battery get EstimatedChargeRemaining /value') do (
    set BatteryLevel=%%I
)

echo ooooooooooooooooooooooooooooooooooo
echo o Battery Status: %BatteryStatus% 
echo o Battery Level: %BatteryLevel%%% 
echo ooooooooooooooooooooooooooooooooooo
echo.

set /p Confirm=Do you want to proceed with generating a battery report? (Y/N): 
if /i "!Confirm!" neq "Y" goto :eof

set /p SaveDir=Enter the directory to save the report (leave blank for C:): 
if "!SaveDir!"=="" set SaveDir=C:

powercfg /batteryreport /output "%SaveDir%\battery_report.html"

echo ooooooo
echo Done. o
echo ooooooo

set /p ConfirmLocation=Do you want to open the directory of the saved report? (Y/N): 
if /i "!ConfirmLocation!" equ "Y" (
    start explorer "%SaveDir%"
)

echo.
echo Thanks for using BATTinfo 5.0 - BATTinfo since 11/14/2023!
echo Link: https://github.com/bladestech/BATTinfo
pause
