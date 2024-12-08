#!/bin/bash

iocURL="http://10.0.17.6/IOC.html"
outFile="IOC.txt"
curl -s "$iocURL" | grep -oP '(?<=<td>).*?(?=</td>)' | sed -n 'p;n' > "$outFile"
echo "Indicators of Compromise (IOC) have been saved to $outFile."
