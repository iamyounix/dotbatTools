@echo off
title dotbatCaffeine by younix v1.0 (contact: iamyounix@gmail.com)
echo.
echo dotbatCaffeine is active.
echo.
:loop
    REM Simulate Shift key press
    powershell.exe -command "$wshell = New-Object -ComObject wscript.shell; $wshell.SendKeys('+')"
    REM Wait for 60 seconds
    timeout /t 60 /nobreak >nul
goto loop