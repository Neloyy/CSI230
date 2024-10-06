#Q1
clear
#Get-Process | Where-Object({$_.Name -ilike "C*"})

#Q2 
#Get-Process | Where-Object{$_.Path -notlike "system32*"} | select Path
<# Q3
$filePath = Join-Path $folderpath "stopped.csv"
$folderpath = "$PSScriptRoot/"
Get-Service | Where-Object{$_.Status -eq "Stopped"} | Export-csv -Path $filePath
#>
#Q4
function openC{
if (Get-Process chrome -ErrorAction SilentlyContinue){Stop-Process -name chrome} else {Start-Process chrome -ErrorAction SilentlyContinue -ArgumentList champlain.edu }

}