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
TIMESTAMP="$(date +%y-%m-%d-%H-%M)"

THRESHOLD=2
MESSAGE=""

VALIDATE(){
    if [ $1 -ne 0 ]; then
        echo  -e "ERROR: $2 .... $R FAILED $W"
        exit 1
    else
        echo -e "$2 .....$G SUCCESS $W"
    fi    
}

mkdir -p $LOG_FOLDER

if [ $USERID -ne 0 ]; then
    echo -e "Please run with $G root user $W" | tee -a $LOG_FILE
    exit 1
fi




VALIDATE(){
    if [ $1 -ne 0 ]; then
        echo  -e "ERROR: $2 .... $R FAILED $W"
        exit 1
    else
        echo -e "$2 .....$G SUCCESS $W"
    fi    
}

mkdir -p $LOG_FOLDER

if [ $USERID -ne 0 ]; then
    echo -e "Please run with $G root user $W" | tee -a $LOG_FILE
    exit 1
fi

DISK_USAGE=$(df -hT |grep -v Filesystem)

while IFS= read -r line
do
    USAGE=$( echo $line | awk '{print $6}' |cut -d '%' -f1 )
    PARTITION=$( echo $line | awk '{print $7}' )

    if [ $USAGE -gt $THRESHOLD ] ; then
        MESSAGE+="Disk High Usage $USAGE% for partition: $PARTITION \n"
    fi
done  <<< $DISK_USAGE

echo -e "Body message: $MESSAGE" | tee -a $LOG_FILE



