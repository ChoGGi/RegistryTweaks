Process Priority,,L
#NoEnv
#NoTrayIcon
#SingleInstance Force
SetBatchLines -1

Loop HKLM,SYSTEM\CurrentControlSet\Control\Session Manager\KnownDLLs,1
  {
  If (A_LoopRegType != "REG_EXPAND_SZ")
    RegDelete HKLM,SYSTEM\CurrentControlSet\Control\Session Manager\KnownDLLs,%A_LoopRegName%
  }
