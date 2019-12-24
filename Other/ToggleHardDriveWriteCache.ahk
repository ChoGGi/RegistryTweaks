#NoEnv
#NoTrayIcon
#SingleInstance Force
Process Priority,,A
SetBatchLines -1

;to do it manually
;start>run>devmgmt.msc>disk drives>"your drive">rightclick>properties>policies>enable write cache / enable advanced performance
;or start>run>regedit>HKLM\SYSTEM\CurrentControlSet\Enum\SCSI\"your drive"\Device Parameters\Disk>rightclick>New>DWORD>UserWriteCacheSetting / CacheIsPowerProtected>double click set to 1 for both

;reboot to apply/save changes

StringTrimRight Title,A_ScriptName,4

MsgBox 4100,%Title%,Yes to Enable`nNo to Disable
IfMsgBox Yes
  ToggleType := 1
Else IfMsgBox No
  ToggleType := 0

Loop 2
  {
  If A_Index = 1
    SubKey := "SCSI"
  Else If A_Index = 2
    SubKey := "IDE"

  Loop HKLM,SYSTEM\CurrentControlSet\Enum\%SubKey%,1,1
    {
    If A_LoopRegName = Class
      {
      RegRead DiskType
      If DiskType = DiskDrive
        {
        RegWrite REG_DWORD,%A_LoopRegKey%,%A_LoopRegSubKey%\Device Parameters\Disk,CacheIsPowerProtected,%ToggleType%
        RegWrite REG_DWORD,%A_LoopRegKey%,%A_LoopRegSubKey%\Device Parameters\Disk,UserWriteCacheSetting,%ToggleType%
        }
      }
    }
  }
Msgbox 4096,%A_Space%,All Done,1

