#NoEnv
#NoTrayIcon
#SingleInstance Force
Process Priority,,A
SetBatchLines -1

;http://support.microsoft.com/kb/297045

Loop HKLM,SYSTEM\CurrentControlSet\Control\Class\{36FC9E60-C465-11CF-8056-444553540000},2
  {
  RegRead ThrowAwayVar,HKLM,SYSTEM\CurrentControlSet\Control\Class\{36FC9E60-C465-11CF-8056-444553540000}\%A_LoopRegName%,Controller
  If !ErrorLevel
    RegWrite REG_DWORD,HKLM,SYSTEM\CurrentControlSet\Control\Class\{36FC9E60-C465-11CF-8056-444553540000}\%A_LoopRegName%,IdleEnable,1
  }
Msgbox 4096,%A_Space%,All Done,1
