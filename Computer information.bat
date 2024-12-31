@ECHO OFF

:: This batch file details Windows 10, hardware, and networking configuration.

TITLE My System Info

:: Colors setup using PowerShell
CALL :CYAN Please wait... Checking system information.
ECHO.

:: Section 1: Windows 10 information
CALL :YELLOW ==========================
ECHO. WINDOWS INFO
CALL :YELLOW ============================
ECHO.

CALL :YELLOW Boot Time:
systeminfo | find /i "Boot Time"
ECHO.


wmic path SoftwareLicensingService get OA3xOriginalProductKey


CALL :YELLOW BIOS Serial Number:
wmic bios get serialnumber
ECHO.

CALL :YELLOW Host Name:
systeminfo | findstr /c:"Host Name"
ECHO.

CALL :YELLOW Domain:
systeminfo | findstr /c:"Domain"
ECHO.

CALL :YELLOW OS Name:
systeminfo | findstr /c:"OS Name"
ECHO.

CALL :YELLOW OS Version:
systeminfo | findstr /c:"OS Version"
ECHO.

CALL :YELLOW System Model:
systeminfo | findstr /c:"System Model"
ECHO.

CALL :YELLOW System Type:
systeminfo | findstr /c:"System Type"
ECHO.

CALL :YELLOW System Manufacturer:
systeminfo | findstr /c:"System Manufacturer"
ECHO.

CALL :YELLOW Baseboard Info:
wmic baseboard get product,Manufacturer,version,serialnumber
ECHO.

:: Section 2: Hardware information.
CALL :BLUE ============================
ECHO. HARDWARE INFO
CALL :BLUE ============================
ECHO.

CALL :YELLOW Total Physical Memory:
systeminfo | findstr /c:"Total Physical Memory"
ECHO.

CALL :YELLOW CPU Name:
wmic cpu get name
ECHO.

CALL :YELLOW Disk Drive Information:
wmic diskdrive get name,model,size
ECHO.

CALL :YELLOW Physical Disk:
powershell get-physicaldisk
ECHO.

CALL :YELLOW Video Controller Info:
wmic path win32_videocontroller get name
ECHO.

CALL :YELLOW Video Resolution Info:
wmic path win32_VideoController get CurrentHorizontalResolution,CurrentVerticalResolution
ECHO.

:: Section 3: Networking information.
CALL :BLUE ============================
ECHO. NETWORK INFO
CALL :BLUE ============================
ECHO.

CALL :YELLOW IPv4 Address:
ipconfig | findstr IPv4
ECHO.

CALL :YELLOW Windows Version Info:
winver
ECHO.

:: End of script
CALL :CYAN =======================================
CALL :CYAN End of System Information
CALL :CYAN =======================================
ECHO.

PAUSE
GOTO :EOF

:: Functions to output colored text

:RED
powershell -Command Write-Host "%*" -foreground "Red"
GOTO :EOF

:GREEN
powershell -Command Write-Host "%*" -foreground "Green"
GOTO :EOF

:BLUE
powershell -Command Write-Host "%*" -foreground "Blue"
GOTO :EOF

:YELLOW
powershell -Command Write-Host "%*" -foreground "Yellow"
GOTO :EOF

:CYAN
powershell -Command Write-Host "%*" -foreground "Cyan"
GOTO :EOF

:MAGENTA
powershell -Command Write-Host "%*" -foreground "Magenta"
GOTO :EOF
Explanation of Color Functions: