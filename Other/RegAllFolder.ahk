Process Priority,,A
#NoEnv
#NoTrayIcon
#SingleInstance Force
SetBatchLines -1

;merge the .reg files in a folder into a single .reg then optionally merge that regfile into the registry

FileSelectFolder RegFolder,*%A_WorkingDir%,3,Select folder with .reg files
If ErrorLevel
  ExitApp
Loop %RegFolder%\*.reg,,1
  {
  FileRead InFile,%A_LoopFileLongPath%
  Char := (StrLen(InFile) - 1)
  Char := SubStr(InFile,Char,1)
  If (Char = "`n")
    RegFileTmp .= InFile
  Else
    RegFileTmp .= InFile "`n"
  }
RegFileTmp := StrReplace(RegFileTmp,"REGEDIT4")
RegFileTmp := StrReplace(RegFileTmp,"Windows Registry Editor Version 5.00")
RegFile := "¢"
Loop Parse,RegFileTmp,`n,`r
  {
  If (A_LoopField = "")
    Continue
  Char := SubStr(A_LoopField,1,1)
  If (Char = "`;")
    Continue
  RegFile .= A_LoopField "`n"
  }
RegFile := StrReplace(RegFile,"`n`n","`n")
RegFile := StrReplace(RegFile,"`n `n","`n")
RegFile := StrReplace(RegFile,"¢","REGEDIT4`n`n")
FileDelete %A_ScriptDir%\RegAllTemp.reg
FileAppend %RegFile%,%A_ScriptDir%\RegAllTemp.reg

MsgBox 4,,Merge %A_ScriptDir%\RegAllTemp.reg?
IfMsgBox Yes
  {
  Run regedit.exe /s %A_ScriptDir%\RegAllTemp.reg
  SoundPlay %A_WinDir%\Media\tada.wav,Wait
  }
