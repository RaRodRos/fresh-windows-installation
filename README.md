# Fresh Windows Installation

To execute all the tweaks paste in Powershell:

```Powershell
iex (New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/RaRodRos/fresh-windows-installation/master/main.ps1')
```

1. **main.ps1:** downloads the scripts and executes them in an administrator session
2. **Set-LowUAC.ps1:** Sets no UAC prompts
3. **Set-RunAsAdministratorBypass.ps1:** Adds an entry in the contextual menu to execute ps1 files as administrator with the bypass execution policy
4. **RunAsAdministratorBypass:** does the same as #3, but on reg format
5. **Install-PMSoftware.ps1:** installation of the software I use available in Winget or Chocolatey
6. **list-pm_software.json:** list of the software available through package managers (necessary for script #4)
7. **list-manual_software.json:** list of the software **not** available through package managers
