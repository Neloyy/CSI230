function ApacheLogs($page,$code,$brower) {
    $notfounds = Get-Content C:\xampp\apache\logs\access.log | Select-String "$code"

    $regex = [regex] "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"

    $ips = @()

    foreach ($line in $notfounds) {
        if ($line -like "*$page*" -and $line -like "*$browser*") {
            $ipMatches = $regex.Matches($line)
            foreach ($match in $ipMatches) {
                $ips += [pscustomobject]@{"IP" = $match.Value}
            }
        }
    }

    $counts = $ips | Group-Object IP | Select-Object Count, Name

    return $counts
}

#ApacheLogs 'index.html' 404 'chrome'
