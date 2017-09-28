Process Priority,,L
#NoEnv
#NoTrayIcon
#SingleInstance Force
SetBatchLines -1

RegWrite REG_EXPAND_SZ,HKLM,SYSTEM\CurrentControlSet\Services\Tcpip\Parameters,DataBasePath,%SystemRoot%\System32\drivers\etc
