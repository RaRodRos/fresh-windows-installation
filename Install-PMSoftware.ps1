# Ra! basic software installation with Chocolatey and Winget

Set-ExecutionPolicy Bypass -Scope Process -Force

try {
	$listPMSoftware = (New-Object System.Net.WebClient).DownloadString('')
}
catch {
	$listPMSoftware = Get-Content -LiteralPath (Join-Path -Path $PSScriptRoot -ChildPath 'list-pm_software.json') -raw
}

# Installing Winget
Write-Verbose "Checking winget..."
if (!(Test-Path ~\AppData\Local\Microsoft\WindowsApps\winget.exe)){
    # Installing winget from the Microsoft Store
	Write-Verbose "Winget not found, installing it now."
	Start-Process "ms-appinstaller:?source=https://aka.ms/getwinget"
	$nid = (Get-Process AppInstaller).Id
	Wait-Process -Id $nid
	Write-Verbose "Winget Installed"
}

# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco install chocolatey-core.extension -y
# Chocolatey remembers the arguments used in the packages installation when updating
choco feature enable -n=useRememberedArgumentsForUpgrades

# Get software list from json
[System.Collections.ArrayList]$errorList = @()
$progList = ConvertFrom-Json -InputObject $listPMSoftware
$categories = $progList.Psobject.Properties.Name
$currentCategory = 0

# Install software
foreach($category in $categories){
	$currentCategory += 1
	$CurrentProgram = 0
	$programs = $progList.$category
	Write-Progress -Id 0 -Activity "$category software" -PercentComplete ($currentCategory / $categories.Count * 100)
	foreach($program in $programs) {
		$CurrentProgram += 1
		if ($program.Skip) { continue }
		Write-Progress -Id 1 -ParentId 0 -Activity "Installing $($program.command) package" -PercentComplete ($currentProgram / $programs.Count * 100)
		switch ($program.packageManager) {
			"choco" { choco install -y -r --ignoredetectedreboot $program.command }
			"winget" { winget install -e -h --id $program.command }
			default {
				Write-Verbose "Package manager not found"
				$LASTEXITCODE = 1
			}
		}
		if ($LASTEXITCODE -gt 0) { $errorList.Add($pm) }
	}
}

# Error notification
if ($errorList.Count -ne 0) {
	Write-Warning @"
	ERRORS INSTALLING:"
$($errorList | out-string)
"@
}

# Pause