# Ra! basic software installation with Chocolatey and Winget

Set-ExecutionPolicy Bypass -Scope Process -Force

$jsonListUrl = 'https://git.io/JrieU'
try {
	$listPMSoftware = (New-Object System.Net.WebClient).DownloadString($jsonListUrl)
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
choco feature enable -n=useEnhancedExitCodes

$PMCommands = @{
	winget = [PSCustomObject]@{
		list = "list", "--exact", "--id"
		upgrade = "upgrade", "--exact", "--silent", "--id"
		install = "install", "--exact", "--silent", "--id"
	}
	choco = [PSCustomObject]@{
		list = "list", "--limitoutput", "--localonly", "--exact"
		upgrade = "upgrade", "--limitoutput", "--yes", "--ignoredetectedreboot"
		install = "install", "--limitoutput", "--yes", "--ignoredetectedreboot"
	}
}

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
		Id = 0
		Activity = "$category software"
		PercentComplete = ($categoryCounter / $categories.Count * 100)
	}
	Write-Progress @outsideWrite

	foreach($program in $programs) {
		$skip = !($progList.$category.$program.skip)
		if ($skip) { continue }

		$packageManager = $progList.$category.$program.packageManager
		$id = $progList.$category.$program.id
		$params = $progList.$category.$program.parameters
		$list = $PMCommands[$packageManager].list
		$upgrade = $PMCommands[$packageManager].upgrade
		$install = $PMCommands[$packageManager].install
		
		$programCounter += 1
		$insideWrite = @{
			Id = 1
			ParentId = 0
			Activity = "Installing $($program) package"
			PercentComplete = ($programCounter / $programs.Count * 100)
		}
		Write-Progress @insideWrite

		$LASTEXITCODE = 501
		& $packageManager $list $id | Out-Null
		if ($LASTEXITCODE -eq 0) {
			& $packageManager $upgrade $id
			continue
		}
		& $packageManager $install $id $params
		if ($LASTEXITCODE -ne 0) { $errorList.Add($program) }
	}
}

# Error notification
if ($errorList.Count -ne 0) {
	Write-Warning @"
	PROBLEMS INSTALLING:"
$($errorList | out-string)
"@
}