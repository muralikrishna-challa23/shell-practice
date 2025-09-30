#!/bin/bash

set -euo pipefail

R="\e[31m"
G="\e[32m"
Y="\e[33m"
W="\e[0m"

USERID=$(id -u)
LOG_FOLDER="/var/log/shell_log"
SCRIPT_NAME="$(echo $0 | cut -d '.' -f1 )"
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME.log"

echo -e "Log path: $R $LOG_FOLDER $W"
echo -e "Script Name: $G $SCRIPT_NAME.sh $W"
echo -e "log file name: $Y $LOG_FILE $W"

if [$USERID -ne 0]; then
    echo -e "Please run with $G root user $W"
    exit 1
fi

FILES=$(find $1 -name '*.log' -type f -mtime +14)

echo $FILES

echo "for loop:"

for filename in $FILES
do
        echo $filename
done

echo "while loop:"

while IFS= read -r filename;
do
 echo $filename
done <<< $FILES

