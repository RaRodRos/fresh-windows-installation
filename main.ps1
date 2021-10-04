$main = [Scriptblock]::Create((New-Object System.Net.WebClient).DownloadString())
$setLowUAC = [Scriptblock]::Create((New-Object System.Net.WebClient).DownloadString())
$installPMSoftware = [Scriptblock]::Create((New-Object System.Net.WebClient).DownloadString())

# Relaunch the script in administrator mode if necessary
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -NoExit -Command $main" -Verb RunAs
	Exit
}

& $setLowUAC
& $installPMSoftware