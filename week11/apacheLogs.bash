#!bin

file="/var/log/apache2/access.log"

#tail -n 20 "$file"
#results=$(cat "$file" | grep 'page2\.html' | cut -d' ' -f1,7 | tr -d "/" ) 

#echo "$results"
function getAllLogs(){
allLogs=$(cat "$file" | cut -d' ' -f1,4,7 | tr -d "[")
}
getAllLogs
#echo "$allLogs"
function pageCount(){
sortedLogs=$(echo "$allLogs" | cut -d'/' -f4 | sort | uniq -c)
}
#pageCount
echo "$sortedLogs"
function curlCount(){
curl=$(cat "$file" | grep "curl\/7\.81\.0" | cut -d' ' -f1,12| sort | uniq -c ) 
echo "$curl"
}
curlCount
