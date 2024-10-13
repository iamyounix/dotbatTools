@echo off
setlocal EnableDelayedExpansion

:menu
cls
echo ===========================================
echo              Welcome Users              
echo ===========================================
echo.
echo Please select an option:
echo.
echo     1. Rename single/multiple files
echo     2. Rename single/multiple folders
echo.
set /p choice=Enter your choice (1 or 2): 
echo.
if %choice%==1 goto renameFiles
if %choice%==2 goto renameFolders
echo ===========================================
echo     Invalid choice. Please try again.
echo ===========================================
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
echo ===========================================
echo       Files renamed successfully. 
echo ===========================================
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
echo ===========================================
echo      Folders renamed successfully.
echo ===========================================
pause
goto menu

:getDir
echo ===========================================
echo Enter the full path of the directory containing the %1 you want to rename:
echo For example, Z:\Shared\Folder or \\NetworkPath\Shared\Folder
echo ===========================================
echo.
set /p dirPath=
if not exist "%dirPath%" (
    echo ===========================================
    echo      Directory does not exist. 
    echo           Please try again. 
    echo ===========================================
    pause
    exit /b 1
)
exit /b 0

:listItems
echo ===========================================
echo %2 in the directory:
echo ===========================================
echo.
for /f "delims=" %%x in ('dir "%dirPath%\*" /b %2') do echo     + %%x
echo.
exit /b 0

:getRenameParams
echo ===========================================
echo Enter the part of the name to find:
echo ===========================================
echo.
set /p findText=
echo.
echo ===========================================
echo Enter the text to replace with:
echo ===========================================
echo.
set /p replaceText=
echo.
exit /b 0

:end
echo ===========================================
echo             Exiting script...
echo ===========================================
exit /b
