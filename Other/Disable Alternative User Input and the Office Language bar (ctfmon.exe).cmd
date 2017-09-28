@echo off

echo.
echo disable Alternative User Input and the Office Language bar (ctfmon.exe)
echo.
regsvr32.exe /u /s %systemroot%\system32\msimtf.dll
regsvr32.exe /u /s %systemroot%\system32\msctf.dll
regsvr32.exe /u /s %systemroot%\system64\msimtf.dll
regsvr32.exe /u /s %systemroot%\system64\msctf.dll
echo -------------------------------------

pause