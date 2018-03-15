Process Priority,,A
#NoEnv
#NoTrayIcon
#SingleInstance Force
SetBatchLines -1

MsgBox Example: Edit before running
ExitApp

DriverPath := "R:\Path to\Drivers"

RegWrite REG_EXPAND_SZ,HKLM,SYSTEM\CurrentControlSet\Services\AFD,ImagePath,\??\%DriverPath%\afd.sys
RegWrite REG_EXPAND_SZ,HKLM,SYSTEM\CurrentControlSet\Services\IpNat,ImagePath,\??\%DriverPath%\ipnat.sys
RegWrite REG_EXPAND_SZ,HKLM,SYSTEM\CurrentControlSet\Services\NetBT,ImagePath,\??\%DriverPath%\netbt.sys
RegWrite REG_EXPAND_SZ,HKLM,SYSTEM\CurrentControlSet\Services\Tcpip,ImagePath,\??\%DriverPath%\tcpip.sys

RegWrite REG_EXPAND_SZ,HKLM,SYSTEM\CurrentControlSet\Services\NVENETFD,ImagePath,\??\%DriverPath%\NVENETFD.sys

;no \??\ thingy
RegWrite REG_EXPAND_SZ,HKLM,SYSTEM\CurrentControlSet\Services\ATI Smart,ImagePath,%DriverPath%\ati2sgag.exe

Msgbox 4096,%A_Space%,All Done,1
Return
