@echo off
setlocal enabledelayedexpansion

REM Function to list all drives
:ListDrives
cls
echo.
echo ==========================================
echo          Available Drives
echo ==========================================
echo.
set driveList=
for /f "tokens=2 delims==" %%D in ('wmic logicaldisk get name /format:value') do (
    echo   %%D
    set driveList=!driveList! %%D
)
echo.
goto SelectDrive

REM Function to select a drive and perform operations
:SelectDrive
set /p drive=Enter the drive letter you want to select (e.g., C): 
REM Add colon if not present
if "!drive:~-1!" neq ":" set drive=%drive%:

REM Check if the drive is valid
set validDrive=false
for %%D in (!driveList!) do (
    if "%%D"=="!drive!" set validDrive=true
)

if "!validDrive!"=="false" (
    echo.
    echo ==========================================
    echo          Invalid drive selected
    echo       Please try again...
    echo ==========================================
    pause
    goto SelectDrive
)

REM Apply the commands
echo.
echo ==========================================
echo Deleting .DS_STORE files and ._* hidden files on %drive%
echo ==========================================
del /s /q /f /a %drive%\*.DS_STORE
del /s /q /f /a:h %drive%\._*

REM Return to main menu
goto MainMenu

:MainMenu
cls
echo.
echo ==========================================
echo          Drive Cleanup Complete
echo ==========================================
echo.
echo 1. List Drives
echo 2. Exit
echo.
set /p choice=Enter your choice (1 or 2): 

if %choice%==1 goto ListDrives
if %choice%==2 goto End

:End
echo.
echo ==========================================
echo         Exiting script...
echo ==========================================
endlocal
exit /b