# Ra! basic software

[string[]]$chocProgs = @(
	#####
	# Software development
	#####
	# 'AdoptOpenJDK --params=" /ADDLOCAL=FeatureMain,FeatureEnvironment,FeatureJarFileRunWith,FeatureJavaHome /INSTALLDIR=C:\Program Files\AdoptOpenJDK\ /quiet "'
	'nodejs'
	# 'python'
	# 'android-sdk'
	# 'eclipse'
	# 'sublimetext3'
	'vscode'
	# 'velocity'
	# 'mobaxterm'
	# 'bitnami-xampp'
	'git'
	'gitkraken'

	#####
	# Notes and writing
	#####
	'whale'
	'joplin'
	'drawio --params="/Associate"'
	'yed --params="/Associate"'

	#####
	# Media Libraries
	#####
	# 'calibre'
	# 'mp3tag'
	'plexmediaserver'
	# 'plex'

	#####
	# Messaging
	#####
	'whatsapp'
	'whatsapptray'
	'telegram'
	'skype'
	'Thunderbird -packageParameters "l=en-US"'
	# 'wickr'
	# 'discord'
	'droidcamclient'

	#####
	# Downloads
	#####
	'4k-video-downloader'
	'jdownloader'
	'qbittorrent'

	#####
	# Browsers
	#####
	'Firefox --params "/l:en-US /RemoveDistributionDir"'
	# 'tor-browser'
	# 'googlechrome'

	#####
	# Videogames
	#####
	'steam'
	'epicgameslauncher'
	'goggalaxy'
	'itch'
	'origin'
	'playnite'
	'geforce-experience'
	'moonlight-qt'

	#####
	# Graphic design
	#####
	'blender'
	'krita'
	'nexusfont'
	'nomacs'
	'exiftool'
	'exiftoolgui'
	'antidupl'

	#####
	# Cloud software
	#####
	'googledrive'
	'dropbox'
	'onedrive'

	#####
	# Files and system administration
	#####
	'powershell-core --packageparameters "/CleanUpPath" --install-arguments=" ADD_FILE_CONTEXT_MENU_RUNPOWERSHELL=1 ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 REGISTER_MANIFEST=1 # ENABLE_PSREMOTING=1 "'
	'7zip'
	'winrar'
	'pandoc'
	'renamer'
	'advanced-renamer'
	'coretemp'
	# 'sagethumbs'
	# 'freefilesync'
	'powertoys'
	'procexp'
	'windirstat'
	'tcpview'
	'teamviewer'
	'grepwin'
	'everything --params " /desktop-shortcut /folder-context-menu /quick-launch-shortcut /run-on-system-startup /start-menu-shortcuts "'

	#####
	# Video tools
	#####
	'mpc-be'
	'vlc'
	'mediainfo'
	'mkvtoolnix'
	'gmkvextractgui'
	'subtitleedit'
)

[string]$chocNotInstalledProgs = $null

#####
# Deactivating security prompts
#####
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Type DWord -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "PromptOnSecureDesktop" -Type DWord -Value 0

# #####
# Chocolatey remembers the arguments used in the packages installation when updating
# #####
choco feature enable -n=useRememberedArgumentsForUpgrades

#####
# Installing chocolatey software
#####
$chocProgs | ForEach-Object {
	choco install -y --ignoredetectedreboot $_
	if ($LASTEXITCODE -ne 0) {
		$chocNotInstalledProgs = $chocNotInstalledProgs + "|`t- " + $_
	}
}

# Error notification
if ($chocNotInstalledProgs.Length -ne 0) {
	$chocNotInstalledProgs = $chocNotInstalledProgs.Remove(0,1)
	Write-Output "`n`n`n`nErrors installing:"
	Write-Output $chocNotInstalledProgs.Split("|")
}else {
	Write-Output "`n`n`n`nNO ERRORS INSTALLING SOFTWARE"
}
