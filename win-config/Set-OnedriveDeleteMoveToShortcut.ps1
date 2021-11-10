#####
# Delete Onedrive context menu shortcut
# It's required to restart Explorer.exe
#####

$paramsEntry = @{
	Path = "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked"
	Name = "{CB3D0F55-BC2C-4C1A-85ED-23ED75B5106B}"
	Value = ""
	Type = "String"
}

if (Test-Path -Path $paramsEntry.Path) {
	if (Get-ItemProperty -Path $paramsEntry.Path -Name $paramsEntry.Name -ErrorAction 'SilentlyContinue') {
		Write-Output "$($paramsEntry.Path)\$($paramsEntry.Name) already exists"
		Return
	}
}else {
	New-Item -Path $paramsEntry.Path
}

Set-ItemProperty @paramsEntry