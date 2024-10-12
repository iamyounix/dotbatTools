@echo off
setlocal enabledelayedexpansion

REM Display a welcome message with fancy formatting
echo ====================================================
echo.       Welcome to dotbatCleaner v1.0
echo.       The Ultimate Cleanup
echo ====================================================
echo.

REM Setup Disk Cleanup settings
echo Configuring Disk Cleanup settings...
cleanmgr /sageset:1
echo Settings saved successfully.
echo.

REM Prompt the user for confirmation to proceed
set /p proceed="Do you want to proceed with cleanup? (Y/N): "
if /i "%proceed%" neq "Y" (
    echo Cleanup cancelled by the user.
    exit /b
)

REM Run Disk Cleanup with the specified settings
echo Running Disk Cleanup... Please wait.
cleanmgr /sagerun:1

REM Get the path to the user's temporary directory and set up logging
set "TEMP_DIR=%TEMP%"
set "LOG_FILE=CleanupLog.txt"
echo %DATE% %TIME% Cleanup started. > "%LOG_FILE%"

REM Display progress indicator
call :showProgress "Cleaning up temporary files and directories..."

REM Delete files and directories in the temporary folder
for /d %%p in ("%TEMP_DIR%\*") do (
    rmdir "%%p" /s /q 2>nul
    call :progressBar
)
del /f /s /q "%TEMP_DIR%\*.*" 2>nul
call :progressBar

REM Log cleanup completion
echo %DATE% %TIME% Cleanup completed. >> "%LOG_FILE%"

REM Notify user and pause to view output
echo.
echo ====================================================
echo Cleanup completed successfully!
echo Check "%LOG_FILE%" for details.
echo ====================================================
pause
exit /b

REM Function to show progress
:showProgress
set "message=%~1"
echo %message%
goto :eof

REM Function to display a simple progress bar
:progressBar
set /a count+=1
set /p progress=.
if !count! lss 10 (
    ping -n 2 127.0.0.1 >nul
)
goto :eof