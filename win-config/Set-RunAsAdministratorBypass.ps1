# Add an entry to the context menu to execute Powershell files as administrator with bypass policy
# This script do the same as adding RunAsAdministratorBypass.reg to the registry

if (!($psPath = (Get-Process pwsh -ErrorAction 'SilentlyContinue' | Select-Object -First 1).Path)) {
    $psPath = (Get-Process powershell | Select-Object -First 1).Path
}

$paramsEntry = @{
	Path = "Registry::HKLM\software\classes\Microsoft.PowerShellScript.1\Shell"
	Name = "RunAsAdministratorBypass"
	Value = "Execute as administrator with bypass policy"
}
if (Test-Path -Path $paramsEntry.Path) {
	Write-Output "RunAsAdministratorBypass key already exists"
	Return
}
$entry = New-Item @paramsEntry
$entry.SetValue('Icon', $psPath)

$commandParams = @{
	Path = $entry.PSPath
	Name = "Command"
	Value = "$psPath -Command `"& {Start-Process $(Split-Path $psPath -leaf) -ArgumentList `'-ExecutionPolicy Bypass -NoExit -File `"%1`"`' -Verb RunAs}`""
}
New-Item @commandParams | Out-Null

$positionParams = @{
	Path = $entry.PSPath
	Name = "Position"
	Value = "Top"
}
New-Item @positionParams | Out-Null