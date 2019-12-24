@echo off

echo.
echo Allow extended character set in filenames
echo.
%systemroot%\system32\fsutil.exe behavior set allowextchar 1
echo -------------------------------------

pause