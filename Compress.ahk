Process Priority,,R
#NoEnv
#NoTrayIcon
#SingleInstance Force
SetBatchLines -1

SetWorkingDir %A_ScriptDir%
7ZIP := "R:\7-Zip\App\7z.exe"
FileDelete RegistryTweaks.7z
RunWait %7ZIP% a RegistryTweaks.7z * -r -x!*.7z -x!Test -x!.git -x!Compress.ahk -x!Desktop.ini -t7z -m0=PPMd:mem=1024m:o=32 -myx=9 -mtr=off -mx=9 -mo=32 -mhc=on -ms=on -mf=on -mmt=12,,UseErrorLevel Hide
SoundPlay %A_WinDir%\Media\tada.wav,Wait
