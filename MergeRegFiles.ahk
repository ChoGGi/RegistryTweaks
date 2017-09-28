;merges reg files into RegAllRemove.reg and RegAllTweaks.reg

Process Priority,,A
#NoEnv
#NoTrayIcon
#SingleInstance Force
SetBatchLines -1

CombineRegFiles("Tweaks")
CombineRegFiles("Remove")

SoundPlay %A_WinDir%\Media\tada.wav,Wait
ExitApp

CombineRegFiles(FOLDER)
  {
  Loop %A_ScriptDir%\%FOLDER%\*.reg,,1
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
  FileDelete %A_ScriptDir%\RegAll%FOLDER%.reg
  FileAppend %RegFile%,%A_ScriptDir%\RegAll%FOLDER%.reg
  }
