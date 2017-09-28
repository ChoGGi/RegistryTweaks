@ECHO OFF
COLOR 1F
SET V=1.7
TITLE Windows 10 TNBT: The Next Big Tweak v%V% (x64)
ECHO #########################################################
ECHO #                                                       #
ECHO #  WINDOWS 10 BUILD 10240 X64 TNBT: THE NEXT BIG TWEAK  #
ECHO #                                                       #
ECHO #  CURRENT REVISION: %V%                                #
ECHO #  AUTHOR: SEBASTIAN KOEHLING                           #
ECHO #                                                       #
ECHO #########################################################

REM ======================= Registry tweaks =======================
ECHO.
:regstart
set /p registry="Apply registry tweaks? y/n: "
if '%registry%' == 'n' goto servstart
if /i "%registry%" neq "y" goto regstart

:reg0start
set /p reg0="Replace Utilman with CMD? y/n: "
if '%reg0%' == 'n' goto reg1start
if /i "%reg0%" neq "y" goto reg0start
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\utilman.exe" /v "Debugger" /t REG_SZ /d "cmd.exe" /f > NUL 2>&1

:reg1start
set /p reg1="Disable Quick Access as default view in Explorer? y/n: "
if '%reg1%' == 'n' goto reg2start
if /i "%reg1%" neq "y" goto reg1start
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v "LaunchTo" /t REG_DWORD /d 0 > NUL 2>&1

:reg2start
set /p reg2="Show computer shortcut on desktop? y/n: "
if '%reg2%' == 'n' goto reg3start
if /i "%reg2%" neq "y" goto reg2start
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f > NUL 2>&1

:reg3start
set /p reg3="Show file extensions? y/n: "
if '%reg3%' == 'n' goto reg4start
if /i "%reg3%" neq "y" goto reg3start
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f > NUL 2>&1

:reg4start
set /p reg4="Disable lockscreen? y/n: "
if '%reg4%' == 'n' goto reg5start
if /i "%reg4%" neq "y" goto reg4start
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v "NoLockScreen" /t REG_DWORD /d 1 /f > NUL 2>&1

:reg5start
set /p reg5="Enable classic control panel view? y/n: "
if '%reg5%' == 'n' goto reg6start
if /i "%reg5%" neq "y" goto reg5start
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "ForceClassicControlPanel" /t REG_DWORD /d 1 /f > NUL 2>&1

:reg6start
set /p reg6="Hide indication for compressed NTFS files? y/n: "
if '%reg6%' == 'n' goto reg7start
if /i "%reg6%" neq "y" goto reg6start
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCompColor" /t RED_DWORD /d 0 /f > NUL 2>&1

:reg7start
set /p reg7="Disable Windows Update sharing? y/n: "
if '%reg7%' == 'n' goto reg8start
if /i "%reg7%" neq "y" goto reg7start
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DownloadMode" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d 0 /f > NUL 2>&1

:reg8start
set /p reg8="Remove Pin to start? y/n: "
if '%reg8%' == 'n' goto reg9start
if /i "%reg8%" neq "y" goto reg8start
reg delete "HKEY_CLASSES_ROOT\exefile\shellex\ContextMenuHandlers\PintoStartScreen" /f > NUL 2>&1
reg delete "HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\PintoStartScreen" /f > NUL 2>&1
reg delete "HKEY_CLASSES_ROOT\mscfile\shellex\ContextMenuHandlers\PintoStartScreen" /f > NUL 2>&1

:reg9start
set /p reg9="Classic vertical icon spacing? y/n: "
if '%reg9%' == 'n' goto reg10start
if /i "%reg9%" neq "y" goto reg9start
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconVerticalSpacing" /t REG_SZ /d "-1150" /f > NUL 2>&1

:reg10start
set /p reg10="Remove versioning tab from properties? y/n: "
if '%reg10%' == 'n' goto reg11start
if /i "%reg10%" neq "y" goto reg10start
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v NoPreviousVersionsPage /t REG_DWORD /d 1 /f > NUL 2>&1

:reg11start
set /p reg11="Disable jump lists? y/n: "
if '%reg11%' == 'n' goto reg12start
if /i "%reg11%" neq "y" goto reg11start
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f > NUL 2>&1

:reg12start
set /p reg12="Remove telemetry and data collection? y/n: "
if '%reg12%' == 'n' goto reg13start
if /i "%reg12%" neq "y" goto reg12start
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v DontOfferThroughWUAU /t REG_DWORD /d 1 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKLM\COMPONENTS\DerivedData\Components\amd64_microsoft-windows-c..lemetry.lib.cortana_31bf3856ad364e35_10.0.10240.16384_none_40ba2ec3d03bceb0" /v "f!dss-winrt-telemetry.js" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKLM\COMPONENTS\DerivedData\Components\amd64_microsoft-windows-c..lemetry.lib.cortana_31bf3856ad364e35_10.0.10240.16384_none_40ba2ec3d03bceb0" /v "f!proactive-telemetry.js" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKLM\COMPONENTS\DerivedData\Components\amd64_microsoft-windows-c..lemetry.lib.cortana_31bf3856ad364e35_10.0.10240.16384_none_40ba2ec3d03bceb0" /v "f!proactive-telemetry-event_8ac43a41e5030538" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKLM\COMPONENTS\DerivedData\Components\amd64_microsoft-windows-c..lemetry.lib.cortana_31bf3856ad364e35_10.0.10240.16384_none_40ba2ec3d03bceb0" /v "f!proactive-telemetry-inter_58073761d33f144b" /t REG_DWORD /d 0 /f > NUL 2>&1

:reg13start
set /p reg13="Apply Internet Explorer 11 tweaks? y/n: "
if '%reg13%' == 'n' goto reg14start
if /i "%reg13%" neq "y" goto reg13start
reg add "HKCU\SOFTWARE\Microsoft\Internet Explorer\Main" /v "DoNotTrack" /t REG_DWORD /d 1 /f > NUL 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Internet Explorer\Main" /v "Search Page" /t REG_SZ /d "http://www.google.de" /f > NUL 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Internet Explorer\Main" /v "Start Page Redirect Cache" /t REG_SZ /d "http://www.google.de" /f > NUL 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Internet Explorer\Main" /v "DisableFirstRunCustomize" /t REG_DWORD /d 1 /f > NUL 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Internet Explorer\Main" /v "RunOnceHasShown" /t REG_DWORD /d 1 /f > NUL 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Internet Explorer\Main" /v "RunOnceComplete" /t REG_DWORD /d 1 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main" /v "DisableFirstRunCustomize" /t REG_DWORD /d 1 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main" /v "RunOnceHasShown" /t REG_DWORD /d 1 /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main" /v "RunOnceComplete" /t REG_DWORD /d 1 /f > NUL 2>&1
reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Main" /v "DisableFirstRunCustomize" /t REG_DWORD /d 1 /f > NUL 2>&1
reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Main" /v "RunOnceHasShown" /t REG_DWORD /d 1 /f > NUL 2>&1
reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Main" /v "RunOnceComplete" /t REG_DWORD /d 1 /f > NUL 2>&1

:reg14start
set /p reg14="Disable Cortana, Bing Search and Searchbar? y/n: "
if '%reg14%' == 'n' goto reg15start
if /i "%reg14%" neq "y" goto reg14start
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CortanaEnabled" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f > NUL 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f > NUL 2>&1

:reg15start
set /p reg15="Change Logon screen background with accent color? y/n: "
if '%reg15%' == 'n' goto reg16start
if /i "%reg15%" neq "y" goto reg15start
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "DisableLogonBackgroundImage" /t REG_DWORD /d 1 /f > NUL 2>&1

:reg16start
set /p reg16="Disable Windows Error Reporting? y/n: "
if '%reg16%' == 'n' goto reg17start
if /i "%reg16%" neq "y" goto reg16start
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f > NUL 2>&1

:reg17start
set /p reg17="Disable automatic Windows Updates? y/n: "
if '%reg17%' == 'n' goto reg18start
if /i "%reg17%" neq "y" goto reg17start
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v "AUOptions" /t REG_DWORD /d 2 /f > NUL 2>&1

:reg18start
set /p reg18="Disable Hibernation? y/n: "
if '%reg18%' == 'n' goto servstart
if /i "%reg18%" neq "y" goto reg18start
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d 0 /f > NUL 2>&1

ECHO Done...

REM ======================= Removing services =======================
ECHO.
:servstart
set /p services="Apply services tweaks? y/n: "
if '%services%' == 'n' goto schedstart
if /i "%services%" neq "n" if /i "%services%" neq "y" goto servstart

:serv0start
set /p serv0="Disable tracking services? y/n: "
if '%serv0%' == 'n' goto serv1start
if /i "%serv0%" neq "y" goto serv0start
sc config DiagTrack start= disabled > NUL 2>&1
sc config diagnosticshub.standardcollector.service start= disabled > NUL 2>&1
sc config TrkWks start= disabled > NUL 2>&1
sc config WMPNetworkSvc start= disabled > NUL 2>&1

:serv1start
set /p serv1="Disable WAP Push Message Routing Service? y/n: "
if '%serv1%' == 'n' goto serv2start
if /i "%serv1%" neq "y" goto serv1start
sc config dmwappushservice start= disabled > NUL 2>&1

:serv2start
set /p serv2="Disable Windows Search? y/n: "
if '%serv2%' == 'n' goto serv3start
if /i "%serv2%" neq "y" goto serv2start
sc config WSearch start= disabled > NUL 2>&1
del "C:\ProgramData\Microsoft\Search\Data\Applications\Windows\Windows.edb" /s > NUL 2>&1

:serv3start
set /p serv3="Disable Superfetch? y/n: "
if '%serv3%' == 'n' goto serv4start
if /i "%serv3%" neq "y" goto serv3start
sc config SysMain start= disabled > NUL 2>&1

:serv4start
set /p serv4="Disable Windows Defender? y/n: "
if '%serv4%' == 'n' goto schedstart
if /i "%serv4%" neq "y" goto serv4start
sc config WinDefend start= disabled > NUL 2>&1
sc config WdNisSvc start= disabled > NUL 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f > NUL 2>&1
schtasks /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /Disable > NUL 2>&1
schtasks /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /Disable > NUL 2>&1
schtasks /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /Disable > NUL 2>&1
schtasks /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Verification" /Disable > NUL 2>&1
del "C:\ProgramData\Microsoft\Windows Defender\Scans\mpcache*" /s > NUL 2>&1

ECHO Done...

REM ======================= Removing scheduled tasks =======================
ECHO.
:schedstart
set /p schedules="Disable unnecessary scheduled tasks? y/n: "
if '%schedules%' == 'n' goto winappstart
if /i "%schedules%" neq "n" if /i "%schedules%" neq "y" goto schedstart

schtasks /Change /TN "Microsoft\Windows\AppID\SmartScreenSpecific" /Disable > NUL 2>&1
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable > NUL 2>&1
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable > NUL 2>&1
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disable > NUL 2>&1
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable > NUL 2>&1
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable > NUL 2>&1
schtasks /Change /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" /Disable > NUL 2>&1
schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable > NUL 2>&1

ECHO Done...

REM ======================= Removing Windows default apps =======================
ECHO.
:winappstart
set /p winapps="Remove windows default apps? y/n: "
if '%winapps%' == 'n' goto odrivestart
if /i "%winapps%" neq "n" if /i "%winapps%" neq "y" goto winappstart

powershell "Get-AppxPackage *3d* | Remove-AppxPackage" > NUL 2>&1
powershell "Get-AppxPackage *bing* | Remove-AppxPackage" > NUL 2>&1
powershell "Get-AppxPackage *zune* | Remove-AppxPackage" > NUL 2>&1
powershell "Get-AppxPackage *photo* | Remove-AppxPackage" > NUL 2>&1
powershell "Get-AppxPackage *communi* | Remove-AppxPackage" > NUL 2>&1
powershell "Get-AppxPackage *solit* | Remove-AppxPackage" > NUL 2>&1
powershell "Get-AppxPackage *phone* | Remove-AppxPackage" > NUL 2>&1
powershell "Get-AppxPackage *soundrec* | Remove-AppxPackage" > NUL 2>&1
powershell "Get-AppxPackage *camera* | Remove-AppxPackage" > NUL 2>&1
powershell "Get-AppxPackage *people* | Remove-AppxPackage" > NUL 2>&1
powershell "Get-AppxPackage *office* | Remove-AppxPackage" > NUL 2>&1
powershell "Get-AppxPackage *xbox* | Remove-AppxPackage" > NUL 2>&1

ECHO Done...

REM ======================= Disable / Remove OneDrive =======================
ECHO.
:odrivestart
set /p onedrive="Disable OneDrive? y/n: "
if '%onedrive%' == 'n' goto hoststart
if /i "%onedrive%" neq "y" goto odrivestart
reg add "HKLM\Software\Policies\Microsoft\Windows\OneDrive" /v DisableFileSyncNGSC /t REG_DWORD /d 1 /f > NUL 2>&1

ECHO Done...

REM ======================= Blocking Telemetry Servers =======================
ECHO.
:hoststart
set /p hostsblock="Block Windows telemetry servers? y/n: "
if '%hostsblock%' == 'n' goto finish
if /i "%hostsblock%" neq "n" if /i "%hostsblock%" neq "y" goto hoststart

copy "%WINDIR%\system32\drivers\etc\hosts" "%WINDIR%\system32\drivers\etc\hosts.bak" > NUL 2>&1
attrib -r "%WINDIR%\system32\drivers\etc\hosts" > NUL 2>&1
FIND /C /I "vortex.data.microsoft.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO ^0.0.0.0 vortex.data.microsoft.com>>%WINDIR%\system32\drivers\etc\hosts
FIND /C /I "vortex-win.data.microsoft.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO ^0.0.0.0 vortex-win.data.microsoft.com>>%WINDIR%\system32\drivers\etc\hosts
FIND /C /I "telecommand.telemetry.microsoft.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO ^0.0.0.0 telecommand.telemetry.microsoft.com>>%WINDIR%\system32\drivers\etc\hosts
FIND /C /I "telecommand.telemetry.microsoft.com.nsatc.net" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO ^0.0.0.0 telecommand.telemetry.microsoft.com.nsatc.net>>%WINDIR%\system32\drivers\etc\hosts
FIND /C /I "oca.telemetry.microsoft.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO ^0.0.0.0 oca.telemetry.microsoft.com>>%WINDIR%\system32\drivers\etc\hosts
FIND /C /I "oca.telemetry.microsoft.com.nsatc.net" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO ^0.0.0.0 oca.telemetry.microsoft.com.nsatc.net>>%WINDIR%\system32\drivers\etc\hosts
FIND /C /I "sqm.telemetry.microsoft.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO ^0.0.0.0 sqm.telemetry.microsoft.com>>%WINDIR%\system32\drivers\etc\hosts
FIND /C /I "sqm.telemetry.microsoft.com.nsatc.net" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO ^0.0.0.0 sqm.telemetry.microsoft.com.nsatc.net>>%WINDIR%\system32\drivers\etc\hosts
FIND /C /I "watson.telemetry.microsoft.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO ^0.0.0.0 watson.telemetry.microsoft.com>>%WINDIR%\system32\drivers\etc\hosts
FIND /C /I "watson.telemetry.microsoft.com.nsatc.net" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO ^0.0.0.0 watson.telemetry.microsoft.com.nsatc.net>>%WINDIR%\system32\drivers\etc\hosts
FIND /C /I "redir.metaservices.microsoft.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO ^0.0.0.0 redir.metaservices.microsoft.com>>%WINDIR%\system32\drivers\etc\hosts
FIND /C /I "choice.microsoft.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO ^0.0.0.0 choice.microsoft.com>>%WINDIR%\system32\drivers\etc\hosts
FIND /C /I "choice.microsoft.com.nsatc.net" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO ^0.0.0.0 choice.microsoft.com.nsatc.net>>%WINDIR%\system32\drivers\etc\hosts
FIND /C /I "df.telemetry.microsoft.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO ^0.0.0.0 df.telemetry.microsoft.com>>%WINDIR%\system32\drivers\etc\hosts
FIND /C /I "reports.wes.df.telemetry.microsoft.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO ^0.0.0.0 reports.wes.df.telemetry.microsoft.com>>%WINDIR%\system32\drivers\etc\hosts
FIND /C /I "services.wes.df.telemetry.microsoft.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO ^0.0.0.0 services.wes.df.telemetry.microsoft.com>>%WINDIR%\system32\drivers\etc\hosts
FIND /C /I "sqm.df.telemetry.microsoft.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO ^0.0.0.0 sqm.df.telemetry.microsoft.com>>%WINDIR%\system32\drivers\etc\hosts
FIND /C /I "telemetry.microsoft.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO ^0.0.0.0 telemetry.microsoft.com>>%WINDIR%\system32\drivers\etc\hosts
FIND /C /I "watson.ppe.telemetry.microsoft.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO ^0.0.0.0 watson.ppe.telemetry.microsoft.com>>%WINDIR%\system32\drivers\etc\hosts
FIND /C /I "telemetry.appex.bing.net" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO ^0.0.0.0 telemetry.appex.bing.net>>%WINDIR%\system32\drivers\etc\hosts
FIND /C /I "telemetry.urs.microsoft.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO ^0.0.0.0 telemetry.urs.microsoft.com>>%WINDIR%\system32\drivers\etc\hosts
FIND /C /I "telemetry.appex.bing.net:443" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO ^0.0.0.0 telemetry.appex.bing.net:443>>%WINDIR%\system32\drivers\etc\hosts
FIND /C /I "settings-sandbox.data.microsoft.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO ^0.0.0.0 settings-sandbox.data.microsoft.com>>%WINDIR%\system32\drivers\etc\hosts
FIND /C /I "vortex-sandbox.data.microsoft.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO ^0.0.0.0 vortex-sandbox.data.microsoft.com>>%WINDIR%\system32\drivers\etc\hosts
attrib +r "%WINDIR%\system32\drivers\etc\hosts" > NUL 2>&1

:finish
CLS
ECHO #########################################################
ECHO #                                                       #
ECHO #  WINDOWS 10 BUILD 10240 X64 TNBT: THE NEXT BIG TWEAK  #
ECHO #                                                       #
ECHO #  CURRENT REVISION: %V%                                #
ECHO #  AUTHOR: SEBASTIAN KOEHLING                           #
ECHO #                                                       #
ECHO #########################################################
ECHO.
ECHO Installation complete.
ECHO Press any key to exit.
PAUSE > NUL