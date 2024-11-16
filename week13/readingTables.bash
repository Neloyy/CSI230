#!/bin/bash
WEBPAGE_URL="http://10.0.17.6/Assignment.html"
WEBPAGE_CONTENT=$(curl -s "$WEBPAGE_URL")
TEMP_RECORDS=$(echo "$WEBPAGE_CONTENT" | sed -n '/<table id="temp">/,/<\/table>/p' | grep -oP '(?<=<td>).*?(?=<\/td>)' | paste - -)
PRESSURE_RECORDS=$(echo "$WEBPAGE_CONTENT" | sed -n '/<table id="press">/,/<\/table>/p' | grep -oP '(?<=<td>).*?(?=<\/td>)' | paste - -)
IFS=$'\n' read -r -d '' -a TEMP_ROWS <<< "$TEMP_RECORDS"
IFS=$'\n' read -r -d '' -a PRESSURE_ROWS <<< "$PRESSURE_RECORDS"
NUM_ROWS=${#TEMP_ROWS[@]}
if [ "$NUM_ROWS" -ne "${#PRESSURE_ROWS[@]}" ]; then
    echo "Error: Temperature and Pressure tables have a different number of rows."
    exit 1
fi
for ((i = 0; i < NUM_ROWS; i++)); do
    PRESSURE_VALUE=$(echo "${PRESSURE_ROWS[$i]}" | awk '{print $1}')
    PRESSURE_DATETIME=$(echo "${PRESSURE_ROWS[$i]}" | awk '{print $2}')
    TEMP_VALUE=$(echo "${TEMP_ROWS[$i]}" | awk '{print $1}')
    TEMP_DATETIME=$(echo "${TEMP_ROWS[$i]}" | awk '{print $2}')
    echo "$PRESSURE_VALUE $TEMP_VALUE $PRESSURE_DATETIME"
done
