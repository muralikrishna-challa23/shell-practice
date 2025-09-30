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

SOURCE_DIR=$1
DEST_DIR=$2
DAYS="$(3:-14)"

mkdir -p $LOG_FOLDER &>> $LOG_FILE

if [ $USERID -ne 0 ]; then
    echo -e "Please run with $G root user $W" | tee -a $LOG_FILE
    exit 1
fi

VALIDATE(){
    IF [ $1 -ne 0 ]; then
        echo "ERROR: $2 .... $R FAILED $W"
        exit 1
    else
        echo "$2 .....$G SUCCESS $W"
}

if [ ! -d $SOURCE_DIR ]; then
    echo -e "ERROR: $SOURCE_DIR not found" | tee-a $LOG_FILE
fi

if [ ! -d $DEST_DIR ]; then
    echo -e "ERROR: $DEST_DIR not found" | tee-a $LOG_FILE
fi


FILES=$(find $1 -name '*.log' -type f -mtime +14)
VALIDATE $? "List of files found to archive."


while IFS= read -r filename;
do
 echo $filename
done <<< $FILES

