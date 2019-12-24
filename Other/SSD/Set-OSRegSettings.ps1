#Set-OSRegSettings.ps1
param($RAMMb, $NumCPU,$VolType)
if (($RAMMb -eq $null) -or ($NumCPU -eq $null) -or ($VolType -eq $null) -or ($VolType -gt 4))
  {
  "`r"
  "Please specify required paramemters of -RAMMb and -NumCPU and -VolType"
  "Usage: .\OSSettings.ps1 -RAMMb 2048 -NumCPU 2 -VolType 4"
  "Valid VolType values are: 1(few files), 2 or 3(moderate files), 4(many files)"
  "`r"
  exit
  }
$ErrorActionPreference = "SilentlyContinue"
$LogFileName="OSSettings.log"
$LogTime=([System.DateTime]::Now).ToString("dd-MM-yyyy hh:mm:ss")
Add-Content $LogFileName "*********** Settings changed at $LogTime ************"

function SetProperty([string]$path, [string]$key, [string]$Value)
  {
  #Clear Error Count
  $error.clear()
  $oldValue = (Get-ItemProperty -path $path).$key
  #Set the Registry Key
  Set-ItemProperty -path $path -name $key -Type DWORD -Value $Value
  #if error count is 0, regkey was updated OK
  if ($error.count -eq 0)
    {
    $newValue = (Get-ItemProperty -path $path).$key
    $data =  "$path\$key=$oldValue"
    if($oldvalue -eq $null)
      {
      Write-Output "Value for $path\$key created and set to $newValue"
      Add-Content $LogFileName "Value for $path\$key created and set to $newValue"
      }
    else
      {
      Write-Output "Value for $path\$key changed from $oldValue to $newValue"
      Add-Content $LogFileName "Value for $path\$key changed from $oldValue to $newValue"
      }
    }
  #if error count is greater than 0 an error occurred and the regkey was not set
  else
    {
    Add-Content $LogFileName "Error: Could not set key $path\$key"
    Add-Content $LogFileName $Error[$error.count-1].exception.message
    Write-Output "Error: Could not set key $path\$key"
    Write-Output $Error[$error.count-1].exception
    }
  }

SetProperty "HKLM:\SYSTEM\CurrentControlSet\Services\ldap" "ldapclientintegrity" 0x0

#Work out Value of $IoPageLockLimit
$IoPageLockLimit = ($RAMMb - 65) * 1024
if ($IoPageLockLimit -gt 4294967295)
  {
  $IoPageLockLimit = "0xFFFFFFFF"
  }
else
  {
  #Convert to Hexadecimal

  $IoPageLockLimit = "{0:X}" -f $IoPageLockLimit
  $IoPageLockLimit = "0x" + $IoPageLockLimit
  }
SetProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" "IoPageLockLimit" ($IoPageLockLimit)

#Work out Value of $WorkerThreads
$WorkerThreads = $NumCPU * 16
if ($WorkerThreads -gt 64)
  {
  $WorkerThreads = "0x40"
  } #Hexadecimal Value of 64
else
  {
  $WorkerThreads = "{0:X}" -f $WorkerThreads
  $WorkerThreads = "0x" + $WorkerThreads
  }

#SetProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" "AdditionalDelayedWorkerThreads" 0x10
#SetProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" "AdditionalCriticalWorkerThreads" 0x10
SetProperty "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" "MaxWorkItems" 8192
SetProperty "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" "MaxMpxCt" 2048
SetProperty "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" "MaxCmds" 2048
#Value depends of -VolType parameter passed in
SetProperty "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" "NtfsMftZoneReservation" $VolType
SetProperty "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" "NTFSDisableLastAccessUpdate" 1
SetProperty "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" "NTFSDisable8dot3NameCreation" 1
SetProperty "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" "DontVerifyRandomDrivers" 1
SetProperty "HKLM:\System\CurrentControlSet\Services\LanmanServer\Parameters" "Size" 3
SetProperty "HKLM:\System\CurrentControlSet\Control\Session Manager\Memory Management" "LargeSystemCache" 0