<#
.SYNOPSIS
	Switch autologin on or off
.DESCRIPTION
	If autologin is on, the Microsoft account introduced will be used to log in at windows start
.EXAMPLE
	Switch-AutoLogin -user "pecador@outlook.es" -password "jarl"
.EXAMPLE
	Switch-AutoLogin -disable -removeOldCredentials
.INPUTS
	String
.NOTES
	This script will create a copy of the password in the Windows registry, so use it under your own discretion.
	More info in:
	https://docs.microsoft.com/en-us/troubleshoot/windows-server/user-profiles-and-logon/turn-on-automatic-logon
#>
function Switch-AutoLogin {
	[CmdletBinding(DefaultParameterSetName='enable')]
	[Alias()]
	Param (
		[Parameter(
			ParameterSetName='enable',
			Mandatory=$true,
			Position=0)]
		[ValidateNotNullOrEmpty()]
		[Alias("u")]
		[string]
		$user,
		
		[Parameter(
			ParameterSetName='enable',
			Position=1)]
		[AllowEmptyString()]
		[Alias("p")]
		[string]
		$password,
		
		[Parameter(
			ParameterSetName='disable',
			Mandatory=$true)]
		[Alias("d")]
		[switch]
		$disable,

		[Parameter(ParameterSetName='disable')]
		[Alias("r")]
		[switch]
		$removeOldCredentials
	)
	
	begin {
		$loginRegPath = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon'
	}
	
	process {
		if ($psCmdlet.ParameterSetName -eq "enable") {
			Set-ItemProperty $loginRegPath 'AutoAdminLogon' -Value '1' -type String
			Set-ItemProperty $loginRegPath 'DefaultUsername' -Value $user -type String
			Set-ItemProperty $loginRegPath 'DefaultPassword' -Value $password -type String
			Return
		}
		Set-ItemProperty $RegPath 'AutoAdminLogon' -Value '0' -type String
		if ($disable -and $removeOldCredentials) {
			Set-ItemProperty $loginRegPath 'DefaultUsername'
			Set-ItemProperty $loginRegPath 'DefaultPassword'
		}
	}
}