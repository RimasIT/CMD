@echo off
:menu
cls
echo =========================================
echo             Main Menu
echo =========================================
echo 1. User Management
echo 2. Internet
echo 3. BitLocker
echo 4. Exit
echo.
set /p choice="Enter your choice (1-4): "

if "%choice%" == "1" goto user_management
if "%choice%" == "2" goto internet
if "%choice%" == "3" goto bitlocker
if "%choice%" == "4" goto exit

echo Invalid choice. Please try again.
pause
goto menu

:user_management
cls
echo =========================================
echo           User Management Menu
echo =========================================
echo 1. Create User with Password
echo 2. Remove User
echo 3. Add Full Name and Description to User
echo 4. View All Local, Domain, and Azure Users
echo 5. Set Password Never Expires
echo 6. Back to Main Menu
echo.
set /p um_choice="Enter your choice (1-6): "

if "%um_choice%" == "1" goto create_user
if "%um_choice%" == "2" goto remove_user
if "%um_choice%" == "3" goto add_user_details
if "%um_choice%" == "4" goto view_users
if "%um_choice%" == "5" goto set_password_never_expires
if "%um_choice%" == "6" goto menu

echo Invalid choice. Please try again.
pause
goto user_management

:create_user
cls
echo Creating a new user...
set /p username="Enter username: "
set /p password="Enter password: "
echo Select user type:
echo 1. Administrator
echo 2. Standard User
set /p usertype="Enter your choice (1-2): "
if "%usertype%" == "1" (
    net user %username% %password% /add
    net localgroup administrators %username% /add
    if %errorlevel% equ 0 (
        echo Administrator user created successfully.
    ) else (
        echo Failed to create Administrator user.
    )
) else if "%usertype%" == "2" (
    net user %username% %password% /add
    if %errorlevel% equ 0 (
        echo Standard user created successfully.
    ) else (
        echo Failed to create Standard user.
    )
) else (
    echo Invalid choice. User not created.
)
pause
goto user_management

:remove_user
cls
echo Removing a user...
set /p username="Enter username to remove: "
net user %username% /delete
if %errorlevel% equ 0 (
    echo User removed successfully.
) else (
    echo Failed to remove user.
)
pause
goto user_management

:add_user_details
cls
echo Adding full name and description to a user...
set /p username="Enter username to modify: "
set /p fullname="Enter full name: "
set /p description="Enter description: "
wmic useraccount where name="%username%" set FullName="%fullname%", Description="%description%"
if %errorlevel% equ 0 (
    echo User details updated successfully.
) else (
    echo Failed to update user details.
)
pause
goto user_management

:view_users
cls
echo Viewing all local users...
net user
echo.
echo Viewing all domain users (if applicable)...
net user /domain
echo.
echo Viewing all Azure Active Directory users (if applicable)...
az account list --query "[].{Name:name, Type:type}" --output table
echo.
pause
goto user_management

:set_password_never_expires
cls
echo Setting a user's password to never expire...
set /p username="Enter username: "
wmic useraccount where name="%username%" set PasswordExpires=false
if %errorlevel% equ 0 (
    echo Password for user %username% is now set to never expire.
) else (
    echo Failed to set password expiration for user.
)
pause
goto user_management

:internet
cls
echo =========================================
echo             Internet Menu
echo =========================================
echo 1. Check Internet Connection
echo 2. Check DNS Resolution (ping google.com)
echo 3. Check Public IP Address
echo 4. Show Network Interface Configuration
echo 5. Test Network Speed (ping google.com)
echo 6. Run Traceroute to google.com
echo 7. Back to Main Menu
echo.
set /p internet_choice="Enter your choice (1-7): "

if "%internet_choice%" == "1" goto check_connection
if "%internet_choice%" == "2" goto check_dns
if "%internet_choice%" == "3" goto check_public_ip
if "%internet_choice%" == "4" goto check_ipconfig
if "%internet_choice%" == "5" goto test_speed
if "%internet_choice%" == "6" goto run_traceroute
if "%internet_choice%" == "7" goto menu

echo Invalid choice. Please try again.
pause
goto internet

:check_connection
@echo off
:CHECK_CONNECTIVITY
ping -n 1 www.google.com >nul
if %errorlevel% neq 0 (
echo Internet connection lost!
rem Add actions to be taken when the connection is lost
) else (
echo Internet connection is active.
)
timeout /t 1 >nul
goto CHECK_CONNECTIVITY

:check_dns
cls
echo Checking DNS Resolution for google.com...
ping google.com
pause
goto internet

:check_public_ip
cls
echo Checking Public IP Address...
curl ifconfig.me
pause
goto internet

:check_ipconfig
cls
echo Showing Network Interface Configuration...
ipconfig
pause
goto internet

:test_speed
cls
echo Testing Network Speed by pinging google.com...
ping -n 10 google.com
pause
goto internet

:run_traceroute
cls
echo Running Traceroute to google.com...
tracert google.com
pause
goto internet


:bitlocker
cls
echo =========================================
echo             BitLocker Menu
echo =========================================
echo 1. Enable BitLocker on Drive
echo 2. Show BitLocker Recovery Key
echo 3. Disable BitLocker
echo 4. Check BitLocker Status
echo 5. Back to Main Menu
echo.
set /p bl_choice="Enter your choice (1-5): "

if "%bl_choice%" == "1" goto enable_bitlocker
if "%bl_choice%" == "2" goto show_bitlocker_key
if "%bl_choice%" == "3" goto disable_bitlocker
if "%bl_choice%" == "4" goto bitlocker_status
if "%bl_choice%" == "5" goto menu

echo Invalid choice. Please try again.
pause
goto bitlocker

:enable_bitlocker
cls
echo Enabling BitLocker...
set /p drive="Enter the drive letter (e.g., C): "
manage-bde -on %drive%:
if %errorlevel% equ 0 (
    echo BitLocker enabled successfully on drive %drive%.
) else (
    echo Failed to enable BitLocker on drive %drive%.
)
pause
goto bitlocker

:show_bitlocker_key
cls
echo Displaying BitLocker Recovery Key...
set /p drive="Enter the drive letter (e.g., C): "
manage-bde -protectors -get %drive%:
pause
goto bitlocker

:disable_bitlocker
cls
echo Disabling BitLocker...
set /p drive="Enter the drive letter (e.g., C): "
manage-bde -off %drive%:
if %errorlevel% equ 0 (
    echo BitLocker disabled successfully on drive %drive%.
) else (
    echo Failed to disable BitLocker on drive %drive%.
)
pause
goto bitlocker

:bitlocker_status
cls
echo Checking BitLocker Status...
set /p drive="Enter the drive letter (e.g., C): "
manage-bde -status %drive%:
pause
goto bitlocker

:exit
echo Exiting the program...
exit
