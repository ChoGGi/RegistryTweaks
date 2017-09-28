Process Priority,,L
#NoEnv
#NoTrayIcon
#SingleInstance Force
SetBatchLines -1

HostsPath := "R:\Path to\HOSTS"

RegWrite REG_EXPAND_SZ,HKLM,SYSTEM\CurrentControlSet\Services\Tcpip\Parameters,DataBasePath,%HostsPath%
