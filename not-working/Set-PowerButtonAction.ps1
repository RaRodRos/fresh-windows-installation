# It throws "Requested registry access is not allowed"

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes\381b4222-f694-41f0-9685-ff5bb260df2e\4f971e89-eebd-4455-a8de-9e59040e7347\7648efa3-dd9c-4e3e-b566-50f929386280" -Name "ACSettingIndex" -Type dword -Value 1
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes\8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c\4f971e89-eebd-4455-a8de-9e59040e7347\7648efa3-dd9c-4e3e-b566-50f929386280" -Name "ACSettingIndex" -Type dword -Value 1
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes\a1841308-3541-4fab-bc81-f71556f20b4a\4f971e89-eebd-4455-a8de-9e59040e7347\7648efa3-dd9c-4e3e-b566-50f929386280" -Name "ACSettingIndex" -Type dword -Value 1


<#
### Related keys:

Equipo\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes\381b4222-f694-41f0-9685-ff5bb260df2e\4f971e89-eebd-4455-a8de-9e59040e7347\7648efa3-dd9c-4e3e-b566-50f929386280

Equipo\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes\8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c\4f971e89-eebd-4455-a8de-9e59040e7347\7648efa3-dd9c-4e3e-b566-50f929386280

Equipo\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes\a1841308-3541-4fab-bc81-f71556f20b4a\4f971e89-eebd-4455-a8de-9e59040e7347\7648efa3-dd9c-4e3e-b566-50f929386280



Equipo\HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Power\PowerSettings\4f971e89-eebd-4455-a8de-9e59040e7347\7648efa3-dd9c-4e3e-b566-50f929386280



Equipo\HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Power\User\PowerSchemes\381b4222-f694-41f0-9685-ff5bb260df2e\4f971e89-eebd-4455-a8de-9e59040e7347\7648efa3-dd9c-4e3e-b566-50f929386280

Equipo\HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Power\User\PowerSchemes\8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c\4f971e89-eebd-4455-a8de-9e59040e7347\7648efa3-dd9c-4e3e-b566-50f929386280

Equipo\HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Power\User\PowerSchemes\a1841308-3541-4fab-bc81-f71556f20b4a\4f971e89-eebd-4455-a8de-9e59040e7347\7648efa3-dd9c-4e3e-b566-50f929386280



Equipo\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\4f971e89-eebd-4455-a8de-9e59040e7347\7648efa3-dd9c-4e3e-b566-50f929386280
#>