@echo off
title Wi-Fi Profile Password Viewer

:: Get all Wi-Fi profiles
echo Fetching Wi-Fi profiles...
netsh wlan show profiles > profiles.txt

:: Initialize counter and display profiles
setlocal enabledelayedexpansion
set counter=0
for /f "tokens=1,* delims=:" %%a in ('findstr /r "^    [A-Za-z0-9]" profiles.txt') do (
    set /a counter+=1
    set profile!counter!=%%b
    echo !counter!. %%b
)

:: Ask user to select a profile
echo.
set /p choice=Enter the number of the profile to view the password: 

:: Check if the input is a valid choice
if "%choice%" gtr "%counter%" (
    echo Invalid choice. Exiting...
    exit /b
)

:: Get the chosen profile's name
set profile_name=!profile%choice%!
set profile_name=!profile_name:~1!

:: Fetch the password for the selected profile
echo Fetching password for profile: !profile_name!
netsh wlan show profile name="!profile_name!" key=clear | findstr /i "Key Content" > temp.txt

:: Display the password
for /f "tokens=2 delims=:" %%a in (temp.txt) do set password=%%a
echo.
if defined password (
    echo Password for !profile_name!: !password!
) else (
    echo No password set for !profile_name!.
)

:: Cleanup
del profiles.txt
del temp.txt
pause