@echo off
title dotbatRename by younix v1.0 (contact: iamyounix@gmail.com)
setlocal EnableDelayedExpansion

:menu
cls
echo ============ Welcome ============
echo.
echo Select an option:
echo.
echo   1. Rename single/multiple files
echo   2. Rename single/multiple folders
echo.
set /p choice=Enter your choice (1 or 2): 
echo.
if %choice%==1 goto renameFiles
if %choice%==2 goto renameFolders
echo   # Invalid choice. Please try again.
echo.
pause
goto menu

:renameFiles
call :getDir "files" || goto renameFiles
call :listItems "%dirPath%" /a-d
call :getRenameParams
for /f "delims=" %%f in ('dir "%dirPath%\*%findText%*" /b /a-d') do (
    set "fileName=%%~nf"
    set "ext=%%~xf"
    set "newName=!fileName:%findText%=%replaceText%!"
    ren "%dirPath%\%%f" "!newName!!ext!"
    echo Renamed: %%f to !newName!!ext!
)
echo.
echo   # Files renamed successfully.
pause
goto menu

:renameFolders
call :getDir "folders" || goto renameFolders
call :listItems "%dirPath%" /ad
call :getRenameParams
for /f "delims=" %%d in ('dir "%dirPath%\*" /b /ad') do (
    set "folderName=%%~nd"
    set "newName=!folderName:%findText%=%replaceText%!"
    ren "%dirPath%\%%d" "!newName!"
    echo Renamed: %%d to !newName!
)
echo.
echo   # Folders renamed successfully.
pause
goto menu

:getDir
echo   # Drag and drop the directory containing the %1 you want to rename:
echo.
set /p dirPath=
if not exist "%dirPath%" (
    echo   # Directory does not exist. Please try again.
    pause
    exit /b 1
)
exit /b 0

:listItems
echo %2 in the directory:
echo.
for /f "delims=" %%x in ('dir "%dirPath%\*" /b %2') do echo   + %%x
echo.
exit /b 0

:getRenameParams
echo   # Enter the part of the name to find:
echo.
set /p findText=
echo.
echo   # Enter the text to replace with:
echo.
set /p replaceText=
echo.
exit /b 0

:end
echo Exiting...
exit /b