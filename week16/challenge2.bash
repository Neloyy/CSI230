#!/bin/bash

if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <log_file> <ioc_file>"
    exit 1
fi
logFile="$1"
iocFile="$2"
outFile="report.txt"
if [[ ! -f "$logFile" || ! -f "$iocFile" ]]; then
    echo "Error: One or both input files do not exist."
    exit 1
fi
> "$outFile"
while IFS= read -r ioc; do
    grep "$ioc" "$logFile" | awk '{print $1, substr($4, 2), $7}' >> "$outFile"
done < "$iocFile"
sort "$outFile" | uniq > temp_report.txt
mv temp_report.txt "$outFile"
