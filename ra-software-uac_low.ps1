# Ra! basic software

$chocParam = "-y --ignoredetectedreboot"
[string[]]$chocProgs = 

# Chocolatey remembers the arguments used in the packages installation when updating
function chocoRemembersArguments {
	choco feature enable -n=useRememberedArgumentsForUpgrades
}

# Ra! basic software

function RaProgsIntall {
	
	# Software development
	choco install AdoptOpenJDK $chocParam `
		--params=" `
			/ADDLOCAL=FeatureMain,FeatureEnvironment,FeatureJarFileRunWith,FeatureJavaHome `
			/INSTALLDIR=C:\Program Files\AdoptOpenJDK\ `
			/quiet `
		"
	# choco install nodejs $chocParam
	# choco install python $chocParam
	# choco install android-sdk $chocParam
	# choco install eclipse $chocParam
	# choco install sublimetext3 $chocParam
	choco install vscode $chocParam
	# choco install velocity $chocParam
	# choco install mobaxterm $chocParam
	# choco install bitnami-xampp $chocParam
	# choco install git $chocParam
	# choco install github-desktop $chocParam
	
	# Notes and writing
		# Unofficial Trello app
	choco install whale $chocParam
	choco install joplin $chocParam
	choco install drawio $chocParam --params="/Associate"
	choco install yed $chocParam --params="/Associate"
	
	# Media Libraries
	# choco install calibre $chocParam
	# choco install mp3tag $chocParam
	choco install plexmediaserver $chocParam
	# choco install plex $chocParam

	# Messaging
	choco install whatsapp $chocParam
	choco install whatsapptray $chocParam
	choco install telegram $chocParam
	choco install skype $chocParam
	choco install Thunderbird $chocParam -packageParameters "l=en-US"
	# choco install wickr $chocParam
	# choco install discord $chocParam

	# Downloads
	choco install 4k-video-downloader $chocParam
	choco install jdownloader $chocParam
	choco install qbittorrent $chocParam

	# Browsers
	choco install Firefox $chocParam --params "/l:en-US /RemoveDistributionDir"
	# choco install tor-browser $chocParam
	# choco install googlechrome $chocParam

	# Videogames
	choco install epicgameslauncher $chocParam
	choco install goggalaxy $chocParam
	choco install itch $chocParam
	choco install origin $chocParam
	choco install steam $chocParam
	choco install geforce-experience $chocParam

	# Graphic design
	choco install blender $chocParam
	choco install krita $chocParam
	choco install nexusfont $chocParam
	choco install nomacs $chocParam
	choco install exiftool $chocParam
	choco install exiftoolgui $chocParam
	choco install antidupl $chocParam	# No está actualizado a 2.3.10 que es más estable

	# Cloud software
	choco install googledrive $chocParam
	choco install dropbox $chocParam
	choco install onedrive $chocParam
	
	# Files and system administration
	choco install powershell-core $chocParam `
		--packageparameters '"/CleanUpPath"' `
		--install-arguments='" `
			ADD_FILE_CONTEXT_MENU_RUNPOWERSHELL=1 `
			ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 `
			REGISTER_MANIFEST=1 `
			# ENABLE_PSREMOTING=1 `
		"'
	choco install 7zip $chocParam
	choco install winrar $chocParam
	choco install pandoc $chocParam
	choco install renamer $chocParam
	choco install advanced-renamer $chocParam
	choco install coretemp $chocParam
	# choco install sagethumbs $chocParam
		# NO FUNCIONA EN CHOCOLATEY
	# choco install freefilesync $chocParam
	choco install powertoys $chocParam
	choco install procexp $chocParam
	choco install windirstat $chocParam
	choco install tcpview $chocParam
	choco install teamviewer $chocParam
	choco install grepwin $chocParam
	choco install everything $chocParam --params " `
		/desktop-shortcut `
		/folder-context-menu `
		/quick-launch-shortcut `
		/run-on-system-startup `
		/start-menu-shortcuts `
	"

	# Video tools
	choco install mpc-be $chocParam
	choco install vlc $chocParam
	choco install mediainfo $chocParam
	choco install mkvtoolnix $chocParam
	choco install gmkvextractgui $chocParam
	choco install subtitleedit $chocParam
}


Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Type DWord -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "PromptOnSecureDesktop" -Type DWord -Value 0