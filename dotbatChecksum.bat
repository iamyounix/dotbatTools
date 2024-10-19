@echo off
setlocal

REM Set the directory and output file
set "directory=%~dp0"
set "output_file=%directory%checksums.txt"

REM Clear the output file if it already exists
if exist "%output_file%" del "%output_file%"

REM Add a header to the output file
echo ====================================================================== >> "%output_file%"
echo                             Checksum Summary                           >> "%output_file%"
echo ====================================================================== >> "%output_file%"
echo. >> "%output_file%"

REM Loop through all .iso, .img, .vhd, .dmg files in the directory and subdirectories
for /r "%directory%" %%f in (*.iso *.img *.vhd *.dmg) do (
    echo Processing "%%~nxf"
    
    REM Add file header
    echo ---------------------------------------------------------------------- >> "%output_file%"
    echo File: %%~nxf >> "%output_file%"
    echo Path: %%~dpnf >> "%output_file%"
    echo ---------------------------------------------------------------------- >> "%output_file%"
    
    REM Calculate MD5 checksum
    echo MD5: >> "%output_file%"
    certutil -hashfile "%%f" MD5 | findstr /v "CertUtil" >> "%output_file%"
    
    REM Calculate SHA-1 checksum
    echo SHA-1: >> "%output_file%"
    certutil -hashfile "%%f" SHA1 | findstr /v "CertUtil" >> "%output_file%"
    
    REM Calculate SHA-256 checksum
    echo SHA-256: >> "%output_file%"
    certutil -hashfile "%%f" SHA256 | findstr /v "CertUtil" >> "%output_file%"
    
    REM Add a blank line for readability
    echo. >> "%output_file%"
)

echo ====================================================================== >> "%output_file%"
echo Checksum calculation completed. See "%output_file%" for results. >> "%output_file%"
echo ======================================================================

endlocal
pause