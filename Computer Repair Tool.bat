@echo off
Title = System, Cleanup AND Maintenance Programs =

If NOT "%1" == "MAX" Start cmd /c %0 MAX & Exit/b

OpenFiles > NUL 2>&1 
If NOT %ERRORLEVEL% EQU 0 Goto :Not_Admin

Set "Msg1=I HOPE YOU FIND THIS PROGRAM USEFUL!"

:: =================================================



echo  Date      %date%
echo  Time      %time%
echo  ==============================================
echo  Hello     %username%
echo  ==============================================
:MENU
ECHO.
ECHO ...............................................
call :RED press any key to continue, or 12 to EXIT.
ECHO ...............................................
ECHO.
ECHO [1] - RUN SFC /SCANNOW
ECHO [2] - RUN DISM /CheckHealth
ECHO [3] - RUN DISM /ScanHealth
ECHO [4] - RUN DISM /RestoreHealth
ECHO [5] - RUN /CHKDSK C: /f
ECHO [6] - RUN /CHKDSK C: /f /r 
ECHO [7] - RUN /CHKDSK C: /f /r /x 
ECHO [8] - RUN Turn OFf Hibernate 
ECHO [9] - Open Startup settings
ECHO [10] - RUN Delete TEMP
ECHO [11] - Clean Disk Tool
ECHO [12] - EXIT
ECHO.

SET /P M=Press any number to ENTER:
IF %M%==1 GOTO SFC
IF %M%==2 GOTO CHECKHEALTH
IF %M%==3 GOTO SCANHEALTH
IF %M%==4 GOTO RESTOREHEALTH
IF %M%==5 GOTO CHKDSKF
IF %M%==6 GOTO CHKDSKR
IF %M%==7 GOTO CHKDSKFRX
IF %M%==8 GOTO HIB
IF %M%==9 GOTO START
IF %M%==10 GOTO TEMP
IF %M%==11 GOTO CLEAN
IF %M%==12 GOTO EXIT

:Not_Admin

echo.
echo  This program MUST be run as an Administrator!
echo.
echo  Right-click the batch file and click ^< Run as administrator ^>.
echo.
echo  ^< Press ANY key to EXIT ^> & Pause > Nul & Goto :Exit

:SFC
echo. & echo  Running [SFC] . . .
sfc.exe /scannow
GOTO MENU
:CHECKHEALTH
echo. & echo  Running [DISM CheckHealth] . . .
DISM /Online /Cleanup-Image /CheckHealth
GOTO MENU
:SCANHEALTH
echo. & echo  Running [DISM ScanHealth] . . .
DISM /Online /Cleanup-Image /ScanHealth
GOTO MENU
:RESTOREHEALTH
echo. & echo  Running [DISM RestoreHealth] . . .
DISM /Online /Cleanup-Image /RestoreHealth
GOTO MENU
:CHKDSKF
echo. & echo  Running [chkdsk /f] . . .
chkdsk C: /f
GOTO MENU
:CHKDSKR
echo. & echo  Running [chkdsk /f /r] . . .
chkdsk C: /f /r
GOTO MENU
:CHKDSKFRX
echo. & echo  Running [chkdsk /f /r] . . .
chkdsk C: /f /r
GOTO MENU
:HIB
echo. & echo  Turning /off hibernate. . .
powercfg.exe /hibernate off
GOTO MENU
:START
echo. & echo  Startup. . .
taskmgr /0 /startup
GOTO MENU
:CLEAN
echo. & echo  Starting Clean Disk Tool. . .
cleanmgr
GOTO MENU
:TEMP
del /s /f /q C:\Windows\Temp\*.*
Explorer C:\Windows\Temp
GOTO MENU
:EXIT
exit
:RED
powershell -Command Write-Host "%*" -foreground "RED"



