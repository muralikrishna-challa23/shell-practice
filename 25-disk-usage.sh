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

DISK_USAGE=$(df -hT |grep -v Filesystem | awk '{print $6}' | cut -d '%' -f1)
DISK_MOUNT=$(df -hT |grep -v Filesystem | awk '{print $7}')

cho -e "Disk high usage: $DISK_USAGE%  for $DISK_MOUNT 

# while IFS= read -r record
# do
#   echo -e "Disk high usage: $DISK_USAGE%  for $DISK_MOUNT"
# done  <<< $DISK_USAGE


