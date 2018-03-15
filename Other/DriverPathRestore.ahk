Process Priority,,A
#NoEnv
#NoTrayIcon
#SingleInstance Force
SetBatchLines -1

MsgBox Example: Edit before running
ExitApp


RegWrite REG_EXPAND_SZ,HKLM,SYSTEM\CurrentControlSet\Services\AFD,ImagePath,system32\DRIVERS\afd.sys
RegWrite REG_EXPAND_SZ,HKLM,SYSTEM\CurrentControlSet\Services\IpNat,ImagePath,system32\DRIVERS\ipnat.sys
RegWrite REG_EXPAND_SZ,HKLM,SYSTEM\CurrentControlSet\Services\NetBT,ImagePath,system32\DRIVERS\netbt.sys
RegWrite REG_EXPAND_SZ,HKLM,SYSTEM\CurrentControlSet\Services\Tcpip,ImagePath,system32\DRIVERS\tcpip.sys

RegWrite REG_EXPAND_SZ,HKLM,SYSTEM\CurrentControlSet\Services\NVENETFD,ImagePath,system32\DRIVERS\NVENETFD.sys


RegWrite REG_EXPAND_SZ,HKLM,SYSTEM\CurrentControlSet\Services\ATI Smart,ImagePath,system32\ati2sgag.exe

Msgbox 4096,%A_Space%,All Done,1
Return
