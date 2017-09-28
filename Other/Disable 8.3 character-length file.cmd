@echo off

echo.
echo Disable 8.3 character-length file
echo.
%systemroot%\system32\fsutil.exe behavior set disable8dot3 1
echo -------------------------------------

pause