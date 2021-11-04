# Fresh Windows Installation

To execute all the tweaks paste in Powershell:

```Powershell
iex (New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/RaRodRos/fresh-windows-installation/master/main.ps1')
```

## main.ps1

Downloads the scripts and executes them in an administrator session

## win-config

Windows tweaks and configuration

1. **Set-AccessibilityKeys.ps1:** Disable sticky keys
1. **Set-DownloadFolder.ps1:** Sets download folder
1. **Set-LowUAC.ps1:** Sets no UAC prompts
1. **Set-NoLogin.ps1:** No login required after waking up the pc
1. **Set-RecentFiles.ps1:** No recent files history
1. **Set-RunAsAdministratorBypass.ps1:** Adds an entry in the contextual menu to execute ps1 files as administrator with the bypass execution policy

## software-installation

1. **Install-PMSoftware.ps1:** Installation of the software I need and it's available in Winget or Chocolatey
1. **list-pm_software.json:** List of the software available through package managers (necessary for script #4)
1. **list-manual_software.json:** List of the software **not** available through package managers
