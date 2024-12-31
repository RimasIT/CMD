@echo off
@setlocal
color 3
echo  ========================================================
echo  =======                                          =======
echo  =======      RESTART COMPUTER WITH TIMER         =======
echo  =======                                          =======
echo. ========================================================
echo.
echo.
echo ----------------------------------------
Set /P _timer=Restart computer after minutes: 
    echo ------------------------
    set /a _result= _timer * 60
    shutdown /s /t %_result%
:step1
    echo Job Done!
    pause