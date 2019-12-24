#Set-NetworkRegSettings.ps1
param([int] $MTUSize = $(throw "usage: ./Set-NetworkSettings <MTU Size>"))


$LogFileName="NetworkRegSettings.log"
$LogTime=([System.DateTime]::Now).ToString("dd-MM-yyyy hh:mm:ss") 
Add-Content $LogFileName "*********** Settings changed at $LogTime ************"

function SetProperty([string]$path, [string]$key, [string]$Value) {
$oldValue = (Get-ItemProperty -path $path).$key
Set-ItemProperty -path $path -name $key -Type DWORD -Value $Value
$newValue = (Get-ItemProperty -path $path).$key
$data =  "$path\$key=$oldValue" 
Add-Content $LogFileName $data
Write-Output "Value for $path\$key changed from $oldValue to $newValue"
}
SetProperty "HKLM:\System\CurrentControlSet\Control\Session Manager\Memory Management" "DisablePagingExecutive" 1
# Set SystemPages to 0xFFFFFFFF
# Maximize system pages. The system creates the largest number of page table entries possible within physical memory. 
# The system monitors and adjusts this value dynamically when the configuration changes.
SetProperty "HKLM:\System\CurrentControlSet\Control\Session Manager\Memory Management" "SystemPages" 0xFFFFFFFF
# HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanmanServer\Parameters
# ============================================================================
$path = "HKLM:\System\CurrentControlSet\Services\LanmanServer\Parameters"
$returnValue = (Get-ItemProperty -path $path).IRPStackSize
if ( $returnValue -eq $null) {
SetProperty $path "IRPStackSize" 0x20 # IRPStackSize -> +10 (Use DWORD 0x20 (32) if not present)
}else{
$returnValue = $returnValue + 1
SetProperty $path "IRPStackSize" $returnValue
}
SetProperty $path "SizReqBuf" 0x4000 # SizReqBuf -> 0x4000 (16384)

# HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters
# =====================================================================
$path = "HKLM:\System\CurrentControlSet\Services\Tcpip\Parameters"
SetProperty $path "DefaultTTL" 0x40 # DefaultTTL -> 0x40 (64)
SetProperty $path "EnablePMTUDiscovery" 1 # EnablePMTUDiscovery -> 1 (do not enable this if your server is directly exposed to potential attackers)
SetProperty $path "EnablePMTUBHDetect" 1 # EnablePMTUBHDetect -> 1 (if your system is using a SOAP or HTTP and/or initiating web connections to other systems)
SetProperty $path "TcpMaxDupAcks" 2 # TcpMaxDupAcks -> 2
SetProperty $path "Tcp1323Opts" 1 # Tcp1323Opts -> 1 (experiment with a value of 3 for possible improved performance, especially if you are experiencing high packet loss/retransmits)
SetProperty $path "SackOpts" 1 # SackOpts -> 1 (VERY important for large TCP window sizes, such as specified below)
SetProperty $path "MaxFreeTcbs" 0x5000 # MaxFreeTcbs -> 0x5000 (20480)
SetProperty $path "TcpMaxSendFree" 0xFFFF # TcpMaxSendFree -> 0xFFFF (65535)
SetProperty $path "MaxHashTableSize" 0xFFFF # MaxHashTableSize -> 0xFFFF (65535)
SetProperty $path "MaxUserPort" 0xFFFF # MaxUserPort -> 0xFFFF (65535)
SetProperty $path "TcpTimedWaitDelay" 0x1E # TcpTimedWaitDelay -> 0x1E (30)
SetProperty $path "GlobalMaxTcpWindowSize" 0xFFFF # GlobalMaxTcpWindowSize -> 0xFFFF (65535)
SetProperty $path "NumTCPTablePartitions" 4 # NumTCPTablePartitions -> 2 per Processor/Core (include processor cores BUT NOT hyperthreading)
# TcpAckFrequency (requires Windows Server 2K3 Hotfix 815230)
# SetProperty $path "TcpAckFrequency" 5 #5 for 100Mb, 13 for 1Gb (requires Windows Server 2K3 Hotfix 815230) - can also be set at the interface level if mixed speeds; only set for connections primarily processing data
SetProperty $path "SynAttackProtect" 0 # SynAttackProtect -> 0 (Only set this on systems with web exposure if other H/W or S/W is providing DOS attack protection)
#Dedicated Network (DATA)
#------------------------
#Interfaces\<adapter ID>\MTU -> 1450-1500, test for maximum value that will pass on each interface using PING -f -l <MTU Size> <Interface Gateway Address>, pick the value that works across all interfaces
$RegistryEntries = Get-ItemProperty -path "HKLM:\system\currentcontrolset\services\tcpip\parameters\interfaces\*"
foreach ( $iface in $RegistryEntries ) { 
$ip = $iface.DhcpIpAddress
if ( $ip -ne $null ) { $childName = $iface.PSChildName}
else {
$ip = $iface.IPAddress
if ($ip -ne $null) { $childName = $iface.PSChildName }
}
$Interface = Get-ItemProperty -path "HKLM:\system\currentcontrolset\services\tcpip\parameters\interfaces\$childName"
$path = $Interface.PSPath
SetProperty $path MTU $MTUSize
}
$path = "HKLM:\System\CurrentControlSet\Services\Tcpip\Parameters"
$ForwardBufferMemory = 100*$MTUSize
SetProperty $path "ForwardBufferMemory" $ForwardBufferMemory # ForwardBufferMemory -> 100*MTUSize, rounded up to the nearest 256 byte boundary
SetProperty $path "MaxForwardBufferMemory" $ForwardBufferMemory # MaxForwardBufferMemory -> ForwardBufferMemory
$NumForwardPackets = $ForwardBufferMemory/256
SetProperty $path "NumForwardPackets" $NumForwardPackets # NumForwardPackets -> ForwardBufferMemory / 256
SetProperty $path "MaxNumForwardPackets" $NumForwardPackets # MaxNumForwardPackets -> NumForwardPackets
SetProperty $path "TcpWindowSize" 0xFBA4 # TcpWindowSize -> 0xFBA4 (64420) (make this a multiple of the TCP MSS (Max Segment Size)
# HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AFD\Parameters
# ===================================================================
$path = "HKLM:\SYSTEM\CurrentControlSet\Services\AFD\Parameters"
SetProperty $path "EnableDynamicBacklog" 1 # EnableDynamicBacklog -> 1
SetProperty $path "MinimumDynamicBacklog" 0xc8 # MinimumDynamicBacklog -> 0xc8 (200)
SetProperty $path "MaximumDynamicBacklog" 0x4e20 # MaximumDynamicBacklog -> 0x4e20 (20000)
SetProperty $path "DynamicBacklogGrowthDelta" 0x64 # DynamicBacklogGrowthDelta -> 0x64 (100)
#S/W Configuration
#=====================================================================
#Disable NETBIOS on cluster private network, if configured 