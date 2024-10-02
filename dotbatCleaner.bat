@echo off
title dotbatCleaner by younix v1.0 (contact: iamyounix@gmail.com)
setlocal enabledelayedexpansion

REM Proceed with the cleanup
echo Welcome to dotbatCleaner v1.0
cleanmgr /sageset:1
echo Settings saved.

REM Confirm before proceeding with cleanup
set /p proceed="Do you want to proceed with cleanup? (Y/N): "
if /i "%proceed%" neq "Y" (
    echo Cleanup cancelled by the user.
    exit /b
)

REM Run Disk Cleanup with the specified settings
cleanmgr /sagerun:1

REM Get the path to the user's temporary directory and set up logging
set "TEMP_DIR=%TEMP%"
set "LOG_FILE=CleanupLog.txt"
echo %DATE% %TIME% Cleanup started. > "%LOG_FILE%"

REM Delete files and directories in the temporary folder
for /d %%p in ("%TEMP_DIR%\*") do (
    rmdir "%%p" /s /q 2>nul
)
del /f /s /q "%TEMP_DIR%\*.*" 2>nul

REM Log cleanup completion
echo %DATE% %TIME% Cleanup completed. >> "%LOG_FILE%"

REM Notify user and pause to view output
echo See "%LOG_FILE%" for details.
pause
exit /b
