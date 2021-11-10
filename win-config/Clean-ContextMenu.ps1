#####
# Delete Skype context menu shortcut
# It's required to restart Explorer.exe after execution
#####

$path = "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked"
$entries = @{
	skypeShare = "{776DBC8D-7347-478C-8D71-791E12EF49D8}"
	onedriveAdd = "{CB3D0F55-BC2C-4C1A-85ED-23ED75B5106B}"
}

if (!(Test-Path -Path $path)) {
	New-Item -Path $path
}

foreach ($key in $entries.Keys) {
	if (Get-ItemProperty -Path $path -Name $entries.$key -ErrorAction 'SilentlyContinue') {
		Write-Output "$key already exists"
		Continue
	}
	Set-ItemProperty -Path $path -Name $entries.$key -Value "" -Type String
}