#!/bin/bash
while true; do
    cpuProc=$(top -bn1 | grep "Cpu" | awk '{print $2 + $4}')
    #echo $cpuProc
    html_file="/var/www/html/StatPage.html"
    sed -i 's/<p id="cpuLoad">[^<]*<\/p>/<p id="cpuLoad">'"${cpuProc}"'<\/p>/' "${html_file}"
    sleep 3
done