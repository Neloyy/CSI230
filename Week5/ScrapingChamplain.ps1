clear
function gatherClasses(){

$page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.38/courses-1.html

$trs=$page.ParsedHtml.body.getElementsByTagName("tr")


$FullTable = @()
for($i=1; $i -lt $trs.length; $i++){
    $tds = $trs[$i].getElementsByTagName("td")

    $Times = $tds[5].innerText.split("-")

    $FullTable += [pscustomobject]@{"Class Code" = $tds[0].innerText; `
                                    "Title"      = $tds[1].innerText; `
                                    "Days"       = $tds[4].innerText; `
                                    "Time Start" = $Times[0];`
                                    "Time End"   = $Times[1];`
                                    "Instructor" = $tds[6].innerText;`
                                    "Location"   = $tds[9].innerText;

}

}
return $FullTable
}
function daysTranslator($FullTable){
for($i=0; $i -lt $FullTable.length; $i++){
$Days = @()

if($FullTable[$i].Days -ilike "M*" ){ $Days += "Monday" }

if($FullTable[$i].Days -ilike "*T[TWF]*" ){ $Days += "Tuesday" }
ElseIf($FullTable[$i].Days -ilike "T" ){ $Days += "Tuesday" }

if($FullTable[$i].Days -ilike "*W*" ){ $Days += "Wednesday" }

if($FullTable[$i].Days -ilike "*TH*" ){ $Days += "Thursday" }

if($FullTable[$i].Days -ilike "*F" ){ $Days += "Friday" }


$FullTable[$i].Days = $Days

#$FullTable | Select-Object "Class Code", Instructor, Location, Days, "Time Start", "Time end"| `
#             Where-Object{$_."Instrustor" -ilike "Furkan"}
}
<#
$FullTable | Select-Object "Class Code", Instructor, Location, Days, "Time Start", "Time End" | `
             Where-Object{$_."Instructor" -ilike "Furkan*"} #>
$ITSInstructors = $FullTable | Where-Object { ($_."Class Code" -like "SYS*") -or `
                                              ($_."Class Code" -like "NET*") -or `
                                              ($_."Class Code" -like "SEC*") -or `
                                              ($_."Class Code" -like "FOR*") -or `
                                              ($_."Class Code" -like "CSI*") -or `
                                              ($_."Class Code" -like "DAT*")}`
                             | Sort-Object "Instructor" `
                             | Select-Object "Instructor" -Unique

$FullTable | Where-Object { ($_.Location -ilike "JOYC 310") -and ($_.days -match "M") } | `
            Sort-Object "Time Start" | `
            Select-Object "Time Start" , "Time End", "Class Code" 
$FullTable            
#$ITSInstructors
<#
$FullTable | Where {$_.Instructor -in $ITSInstructors.Instructor }`
           | Group-Object "Instructor" | Select-Object Count, Name | Sort-Object Count -Descending
           #>
#return $FullTable
}
#gatherClasses
daysTranslator(gatherClasses)