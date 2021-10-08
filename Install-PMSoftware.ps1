# Ra! basic software installation with Chocolatey and Winget

Set-ExecutionPolicy Bypass -Scope Process -Force

try {
	$listPMSoftware = (New-Object System.Net.WebClient).DownloadString('https://git.io/JrieU')
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
	Wait-Process -Id (Get-Process AppInstaller).Id
}
Write-Verbose "Winget Installed"

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
$categoryCounter = 0

# Install software
foreach($category in $categories){
	$categoryCounter += 1
	$programCounter = 0
	$programs = $progList.$category.Psobject.Properties.Name
	$outsideWrite = @{
		Id = 1
		Activity = "$category software"
		PercentComplete = ($categoryCounter / $categories.Count * 100)
	}
	Write-Progress @outsideWrite
	foreach($program in $programs) {
		$install = $progList.$category.$program.install
		if (!$install) { continue }
		$packageManager = $progList.$category.$program.packageManager
		$command = $progList.$category.$program.command
		$programCounter += 1
		$insideWrite = @{
			Id = 1
			ParentId = 0
			Activity = "Installing $($program) package"
			PercentComplete = ($programCounter / $programs.Count * 100)
		}
		Write-Progress @insideWrite
		switch ($packageManager) {
			"winget" {
				winget list -e --id $command
				if ($LASTEXITCODE -eq 0) {
					winget upgrade -e -h --id $command
					continue
				}
				winget install -e -h --id $command
			}
			"choco" {
				choco install -y -r --ignoredetectedreboot $command
			}
			default {
				Write-Verbose "Package manager not found"
				$LASTEXITCODE = 1
			}
		}
		if ($LASTEXITCODE -ne 0) { $errorList.Add($pm) }
	}
}

# Error notification
if ($errorList.Count -ne 0) {
	Write-Warning @"
	ERRORS INSTALLING:"
$($errorList | out-string)
"@
}