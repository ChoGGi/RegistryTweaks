@echo off

echo.
echo Disable Last Access Timestamp
echo.
%systemroot%\system32\fsutil.exe behavior set disablelastaccess 1
echo -------------------------------------

pause