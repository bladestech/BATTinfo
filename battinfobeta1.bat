@echo off
title BATTinfo

echo.
echo  BBBBB  AAAAA TTTTTT TTTTTT III  N   N  FFFFF  OOO  
echo  B   B  A   A   TT     TT    I   NN  N  F     O   O 
echo  BBBBB  AAAAA   TT     TT    I   N N N  FFFF  O   O 
echo  B   B  A   A   TT     TT    I   N  NN  F     O   O 
echo  BBBBB  A   A   TT     TT   III  N   N  F      OOO  


setlocal EnableDelayedExpansion

>nul 2>&1 net session
if %errorLevel% neq 0 (
    echo Administrator permissions required. Please run as administrator.
    pause
    goto :eof
)

for /f "tokens=2 delims==" %%I in ('wmic path Win32_Battery get EstimatedChargeRemaining /value') do (
    set BatteryLevel=%%I
)

echo.
echo Battery Level: %BatteryLevel%%%
echo.

set /p Confirm=Do you want to generate a battery report? (yes/no): 
if /i "!Confirm!" neq "yes" goto :eof

set /p SaveDir=Enter the directory to save the report (leave blank for default location, default is C:): 

if "!SaveDir!"=="" set SaveDir=C:

powercfg /batteryreport /output "%SaveDir%\battery_report.html"

echo Battery report saved to "%SaveDir%\battery_report.html"

set /p ConfirmLocation=Do you want to open the location where the report was saved? (yes/no): 
if /i "!ConfirmLocation!" equ "yes" (
    start explorer "%SaveDir%"
)

echo.
echo Thanks for using my app, feel free to share :D !

pause