# launch a dev server with watched source dir
param ($port = '13131')

$src = Join-Path $PSScriptRoot 'site'
$global:job = Start-Job -ScriptBlock {
	hugo serve -p $using:port -s $using:src
}

