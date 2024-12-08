#!/bin/bash

inFile="report.txt"
outFile="report.html"
if [[ ! -f "$inFile" ]]; then
    echo "Error: $inFile does not exist."
    exit 1
fi
echo "<html>" > "$outFile"
echo "<body>" >> "$outFile"
echo "<p>Access logs with IOC indicators:</p>" >> "$outFile"
echo "<table border=\"1\" style=\"border-collapse: collapse; text-align: left;\">" >> "$outFile"
while IFS= read -r line; do
    ip=$(echo "$line" | awk '{print $1}')
    datetime=$(echo "$line" | awk '{print $2}')
    page=$(echo "$line" | awk '{print $3}')
    
    echo "<tr><td>$ip</td><td>$datetime</td><td>$page</td></tr>" >> "$outFile"
done < "$inFile"
echo "</table>" >> "$outFile"
echo "</body>" >> "$outFile"
echo "</html>" >> "$outFile"
