@echo off

:: Created by: Shawn Brink
:: http://www.tenforums.com
:: Tutorial: http://www.tenforums.com/tutorials/4189-fast-startup-turn-off-windows-10-a.html 


:: To enable hibernate
powercfg -h on


:: To turn on Fast Startup
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /V HiberbootEnabled /T REG_dWORD /D 1 /F



