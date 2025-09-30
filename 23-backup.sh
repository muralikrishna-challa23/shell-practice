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

SOURCE_DIR=$1
DEST_DIR=$2
DAYS="${3:-14}"

USAGE(){
    echo -e "suso sh <script_name> <source_dir> <dest_dir> <days>[Optional: if days not given by default it take as 14]"
    exit 1
}

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

if [ $# -lt 2 ]; then
    USAGE
fi

if [ ! -d $SOURCE_DIR ]; then
    echo -e "ERROR: $SOURCE_DIR not found" | tee-a $LOG_FILE
    exit 1
fi

if [ ! -d $DEST_DIR ]; then
    echo -e "ERROR: $DEST_DIR not found" | tee-a $LOG_FILE
    exit 1
fi

FILES=$(find $SOURCE_DIR -name '*.log' -type f -mtime +$DAYS)
VALIDATE $? "List of files found to archive:: $FILES"

if [ -z $FILES ]; then
    echo -e "No files to archive... $R SKIPPING $W"
else
    FILES=$(find $SOURCE_DIR -name '*.log' -type f -mtime +$DAYS)
    VALIDATE $? "List of files found to archive."
    ZIP_NAME="$DEST_DIR/app-logs-$TIMESTAMP.zip"
    echo -e "zip file name is: $G $ZIP_NAME $W"
    find $SOURCE_DIR -name '*.log' -type f -mtime +$DAYS | zip -@ -j $ZIP_NAME

    if [ -f $ZIP_NAME ]; then
         echo -e "Archiving is ....$G SUCCESS $W"

        while IFS= read -r filename;
        do
            echo "Deleting the file:: $filename"
            rm -rf $filepath
            echo "Deleted the file:: $filename"
        done <<< $FILES
    else
        echo -e "Archival process...$R FAILURE  $W"
        exit 1
    fi
fi