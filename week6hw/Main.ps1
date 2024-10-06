. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Apache-Logs1.ps1)
. (Join-Path $PSScriptRoot processman.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)
clear
function Show-Menu {
    #clear
    Write-Host "1. Display last 10 Apache logs"
    Write-Host "2. Display last 10 failed logins for all users"
    Write-Host "3. Display at-risk users"
    Write-Host "4. Start Chrome web browser and navigate to champlain.edu"
    Write-Host "5. Exit"
}

$flag = $true
while($flag){
Show-Menu
$choice =  Read-Host "Please choose an option (1-5)"
if($choice -eq 1){
    $apacheLogEntries = ApacheLogs1
    $apacheLogEntries | Select-Object -Last 10 | Format-Table -AutoSize
    }
elseif($choice -eq 2){
    $failedLoginAttempts = getFailedLogins 7
    $failedLoginAttempts | Select-Object -Last 10 | Format-Table -AutoSize
    }
elseif($choice -eq 3){
    $failedLoginAttempts = getFailedLogins 30
    $compromisedUsers = $failedLoginAttempts | Group-Object User | Where-Object { $_.Count -ge 10 }
    $compromisedUsers | Format-Table Name, Count
    }
elseif($choice -eq 4){
    $openChrome = openC
    $openChrome
    Write-Host "Opened a new tab with champlain.edu in Chrome."
    <#
    if (Get-Process chrome -ErrorAction SilentlyContinue) {
        Start-Process "chrome" -ArgumentList "https://www.champlain.edu"
        Write-Host "Opened a new tab with champlain.edu in Chrome."
            } 
     else {
        Start-Process "chrome" -ArgumentList "https://www.champlain.edu"
        Write-Host "Chrome started and navigated to champlain.edu."
            }#>
    }
elseif($choice -eq 5){
    Write-Host "Goodbye!"
    exit
    $flag = $false 
}
else{
    Write-Host "Invalid selection. Please enter a number between 1 and 5."
}
}