@echo off

rem "Compatibility" update for upgrading Windows 7
wusa /uninstall /kb:2952664 /quiet /norestart
rem "Compatibility" update for Windows 7 RTM
wusa /uninstall /kb:2977759 /quiet /norestart
rem Update that enables you to upgrade from Windows 7 to a later version of Windows
wusa /uninstall /kb:2990214 /quiet /norestart
rem Update that adds telemetry points to consent.exe in Windows 8.1 and Windows 7
wusa /uninstall /kb:3015249 /quiet /norestart
rem Update to Windows 7 SP1 for performance improvements
wusa /uninstall /kb:3021917 /quiet /norestart
rem Update for customer experience and diagnostic telemetry
wusa /uninstall /kb:3022345 /quiet /norestart
rem Update installs Get Windows 10 app in Windows 8.1 and Windows 7 SP1
wusa /uninstall /kb:3035583 /quiet /norestart
rem Update that enables you to upgrade from Windows 8.1 to a later version of Windows
wusa /uninstall /kb:3044374 /quiet /norestart
rem Update for customer experience and diagnostic telemetry
wusa /uninstall /kb:3068708 /quiet /norestart
rem Update that adds telemetry points to consent.exe in Windows 8.1 and Windows 7
wusa /uninstall /kb:3075249 /quiet /norestart
rem Update for customer experience and diagnostic telemetry
wusa /uninstall /kb:3080149 /quiet /norestart
rem Updated capabilities to upgrade Windows 8.1 and Windows 7
wusa /uninstall /kb:3123862 /quiet /norestart
rem Updated Internet Explorer 11 capabilities to upgrade Windows 8.1 and Windows 7
wusa /uninstall /kb:3146449 /quiet /norestart

pause
