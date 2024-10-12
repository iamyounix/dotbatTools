@echo off
title Awake Mode - Stay Awake in Style!

REM Display a fancy welcome message
echo ====================================================
echo.       Welcome to dotbatCaffeine v1.0
echo.       Keeping Your PC Awake
echo ====================================================
echo.

REM Main loop to simulate Shift key press every 60 seconds
:loop
    REM Fancy progress message
    echo Simulating Shift key press to keep your PC awake...
    
    REM Simulate Shift key press
    powershell.exe -command "$wshell = New-Object -ComObject wscript.shell; $wshell.SendKeys('+')"

    REM Display a sleek waiting message
    echo Waiting for 60 seconds... Stay tuned.
    timeout /t 60 /nobreak >nul

    REM Loop back
    goto loop