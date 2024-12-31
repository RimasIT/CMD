ECHO OFF
CLS
@echo off
:MENU
ECHO.
ECHO ======================================================
ECHO PRESS 1, 2, 3, or 4 to select your task, or 5 to EXIT.
ECHO ======================================================
ECHO.
ECHO 0 - Download Chrome,VLC,Foxit,7ZIP
ECHO 1 - Download RuZuck Software Updater
ECHO 2 - SERIAL NUMBER
ECHO 3 - COMPUTER MODEL
ECHO 4 - BatteryReport "C:\battery-report.html"
ECHO 5 - Bitlocker Status
ECHO 6 - Bitlocker Check
ECHO 7 - CHARMAP
ECHO 8 - Event Viewer
ECHO 9 - Disable FastStartup /off
ECHO 10 - Get Mac Adress 
ECHO 11 - Check ip adresses
ECHO 12 - Open win+R
ECHO 13 - Open Device and Printers Old
ECHO 14 - APPS SHORTCUT
ECHO 15 - DELETE LANGUAGE
ECHO 16 - Windows Version
ECHO 17 - ADD DOMAIN
ECHO 18 - EXIT
ECHO.
SET /P M=Type 1, 2, 3, or 4 then press ENTER:
IF %M%==0 GOTO DOWNLOAD
IF %M%==1 GOTO RUZUCK
IF %M%==2 GOTO SERIAL
IF %M%==3 GOTO MODEL
IF %M%==4 GOTO BATTERY
IF %M%==5 GOTO STATUS
IF %M%==6 GOTO CHECK
IF %M%==7 GOTO CHAR
IF %M%==8 GOTO EVENT
IF %M%==9 GOTO HYBER
IF %M%==10 GOTO GETMAC
IF %M%==11 GOTO CHECKIPADRESS
IF %M%==12 GOTO OpenWINR
IF %M%==13 GOTO DEVICE
IF %M%==14 GOTO APPS
IF %M%==15 GOTO LANGUAGE
IF %M%==16 GOTO WINVER
IF %M%==17 GOTO DOMAIN
IF %M%==18 GOTO EXIT

:DOWNLOAD
start https://ninite.com/7zip-chrome-foxit-vlc/ninite.exe
GOTO MENU
:RUZUCK
start https://github.com/rzander/ruckzuck/releases/download/1.7.3.5/RuckZuck.exe
GOTO MENU
:SERIAL
wmic bios get serialnumber
GOTO MENU
:MODEL
wmic csproduct get name
GOTO MENU
:BATTERY
powercfg /batteryreport /output "C:\battery-report.html"
GOTO MENU
:STATUS
manage-bde -status C:
GOTO MENU
:CHECK
manage-bde -protectors -get C:
GOTO MENU
:CHAR
charmap
GOTO MENU
:HYBER
powercfg.exe /hibernate off
GOTO MENU
:EVENT
eventvwr.msc
GOTO MENU
:GETMAC
getmac
GOTO MENU
:CHECKIPADRESS
arp -a
GOTO MENU
:OpenWINR
explorer.exe Shell:::{2559a1f3-21d7-11d4-bdaf-00c04f60b9f0}
GOTO MENU
:DEVICE
%windir%\explorer.exe shell:::{A8A91A66-3A7D-4424-8D24-04E180695C7A}
GOTO MENU
:APPS
%windir%\explorer.exe shell:::{4234d49b-0245-4df3-b780-3893943456e1}
GOTO MENU
:LANGUAGE
lpksetup /u
GOTO MENU
:WINVER
winver
GOTO MENU
:DOMAIN
sysdm.cpl
GOTO MENU


:EXIT
exit

