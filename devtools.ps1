# Developer functions for Hugo 
#
Set-Alias sahs Start-HugoServer
Set-Alias sphs Stop-HugoServer
Set-Alias rths Restart-HugoServer
Set-Alias ghs Get-HugoServer
Set-Alias rchs Receive-HugoServer

$env:HUGO_BASE_DIR = $PSScriptRoot

function Start-HugoServer {
	Push-Location $env:HUGO_BASE_DIR
	$global:HugoServer = Start-Job { make serve }
	Pop-Location
	$o = $HugoServer | Receive-Job -Keep | Select-Object -Last 2 | Select-Object -First 1

	return $o
}

function Stop-HugoServer {
	$global:HugoServer | Stop-Job -ErrorAction Ignore
}

function Restart-HugoServer {
	Stop-HugoServer
	Start-HugoServer | Write-Output
}

function Receive-HugoServer {
	Receive-Job -Id $($HugoServer.Id) -Keep | Write-Output
}

function Get-HugoServer {
	return Get-Job -Id $($HugoServerJob.Id)
}
