. (Join-Path $PSScriptRoot FunctionsEventLog.ps1)
clear

$loginoutsTable = getLogonRecords 15
$loginoutsTable

$shutdownsTable = getLogoffTime 
$shutdownsTable

$startupsTable = getLogonTime 
$startupsTable