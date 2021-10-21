$main = (New-Object System.Net.WebClient).DownloadString(
		'https://raw.githubusercontent.com/RaRodRos/fresh-windows-installation/master/registry/main.ps1')
$installPMSoftware = (New-Object System.Net.WebClient).DownloadString(
	'https://raw.githubusercontent.com/RaRodRos/fresh-windows-installation/master/registry/Install-PMSoftware.ps1')

$registryChanges = @{
	setLowUAC = (New-Object System.Net.WebClient).DownloadString(
		'https://raw.githubusercontent.com/RaRodRos/fresh-windows-installation/master/registry/Set-LowUAC.ps1')
	setAccessibilityKeys = (New-Object System.Net.WebClient).DownloadString(
		'https://raw.githubusercontent.com/RaRodRos/fresh-windows-installation/master/registry/Set-AccessibilityKeys.ps1')
	setDownloadFolder = (New-Object System.Net.WebClient).DownloadString(
		'https://raw.githubusercontent.com/RaRodRos/fresh-windows-installation/master/registry/Set-DownloadFolder.ps1')
	setRunAsAdministratorBypass = (New-Object System.Net.WebClient).DownloadString(
		'https://raw.githubusercontent.com/RaRodRos/fresh-windows-installation/master/registry/Set-RunAsAdministratorBypass.ps1')
}

if (!$main -or !($setLowUAC -Or $installPMSoftware)) {
	throw "There is no script available"
}

# Relaunch the script in administrator mode if necessary
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -NoExit -Command $main" -Verb RunAs
	Stop-Process -Id $PID
}

foreach ($registryChange in $registryChanges.Values) {
	Invoke-Expression -Command $registryChange
}

Invoke-Expression -Command $installPMSoftware