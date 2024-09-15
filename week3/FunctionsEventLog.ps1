
#Get-EventLog system -Source Microsoft-Windows-winlogon
function getLogonRecords($dateRecords){
$loginouts = Get-EventLog system -Source Microsoft-Windows-winlogon -After (Get-Date).AddDays("-" + $dateRecords)
$loginoutsTable = @()
for($i=0; $i -lt $loginouts.Count; $i++){
$event = ""
if($loginouts[$i].InstanceId -eq 7001) {$event = "Logon"}
if($loginouts[$i].InstanceId -eq 7002) {$event = "Logoff"}


$user = $loginouts[$i].ReplacementStrings[1]
$SID = New-Object System.Security.Principal.SecurityIdentifier($user)
$User = $SID.Translate([System.Security.Principal.NTAccount])


$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
                                        "Id" = $loginouts[$i].InstanceId; `
                                        "Event" = $event; `
                                        "User" = $User.Value;`
                                        }

}
$loginoutsTable
}

function getlogonTime($dateRecords){
    #Get-EventLog -LogName System
    $computeron = Get-WinEvent -FilterHashtable @{logname = 'System'; id = 6005}
    $onTable = @()
    for($i=0; $i -lt $computeron.Count; $i++){
    $event = ""
    #if($computeron[$i].EventID -eq 6005){$event = "Logon"}
  
    for($i=0; $i -lt $computeron.Count; $i++){
    $onTable += [pscustomobject]@{"Time" = $computeron[$i].TimeCreated; `
                                        "Id" = $computeron[$i].Id; `
                                        "Event" = "Computer on"; `
                                        "User" = $User.Value;`
                                        }
}
$onTable
}}

function getlogoffTime(){
    $computeroff = Get-WinEvent -FilterHashtable @{logname = 'System'; id = 6006}
    $offTable = @()
    for($i=0; $i -lt $computeroff.Count; $i++){
    $event = ""
   for($i=0; $i -lt $computeroff.Count; $i++){
    $offTable += [pscustomobject]@{"Time" = $computeroff[$i].TimeCreated; `
                                        "Id" = $computeroff[$i].Id; `
                                        "Event" = "Computer off"; `
                                        "User" = $User.Value;`
                                        }
}
$offTable
}}

getlogonTime 20
getLogoffTime
getLogonRecords 20