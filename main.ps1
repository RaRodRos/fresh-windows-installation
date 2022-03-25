$winConfig = "https://raw.githubusercontent.com/RaRodRos/fresh-windows-installation/master/win-config"

$main = (New-Object System.Net.WebClient).DownloadString(
		'https://raw.githubusercontent.com/RaRodRos/fresh-windows-installation/master/main.ps1')

$winConfig = @{
	setLowUAC = (New-Object System.Net.WebClient).DownloadString("$winConfig/Set-LowUAC.ps1")
	setAccessibilityKeys = (New-Object System.Net.WebClient).DownloadString("$winConfig/Set-AccessibilityKeys.ps1")
	setDownloadFolder = (New-Object System.Net.WebClient).DownloadString("$winConfig/Set-DownloadFolder.ps1")
	setRunAsAdministratorBypass = (New-Object System.Net.WebClient).DownloadString("$winConfig/Set-RunAsAdministratorBypass.ps1")
	setNoLogin = (New-Object System.Net.WebClient).DownloadString("$winConfig/Set-NoLogin.ps1")
	setRecentFiles = (New-Object System.Net.WebClient).DownloadString("$winConfig/Set-RecentFiles.ps1")
}

$installPMSoftware = (New-Object System.Net.WebClient).DownloadString(
	'https://raw.githubusercontent.com/RaRodRos/fresh-windows-installation/master/software-installation/Install-PMSoftware.ps1')

if (!$main -or ($winConfig.Count -eq 0 -and !$installPMSoftware)) {
	throw "There is no script available"
}

# Relaunch the script in administrator mode if necessary
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -NoExit -Command $main" -Verb RunAs
	Stop-Process -Id $PID
}

foreach ($registryChange in $winConfig.Values) {
	Invoke-Expression -Command $registryChange
}

Invoke-Expression -Command $installPMSoftware