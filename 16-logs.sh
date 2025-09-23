#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
W="\e[0m"

LOG_FOLDER="/var/log/shell-script"
SCRIPT_NAME="$(echo $0 | cut -d '.' -f1)"
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOG_FOLDER
echo "Script started executing at: $(date)" | tee -a $LOG_FILE

if [ $USERID -ne 0 ]; then
    echo -e "ERROR::Please run this with root ccess" | tee -a $LOG_FILE
    exit 1
 fi

VALIDATE() {
if [ $1 -ne 0 ]; then
    echo -e "ERROR:: Installing $2 ....$R FAILURE $W" | tee -a $LOG_FILE
    exit 1
 else
    echo -e "Installing $2 .....$G SUCCESS $W"    | tee -a $LOG_FILE
 fi
}

dnf list installed mysql -y
if [ $? -ne 0 ]; then
    dnf install mysql -y
    VALIDATE $? "MYSQL"
else
    echo -e "MYSQL is already installed ....$Y SKIPPING $W" | tee -a $LOG_FILE
fi

dnf list installed nginx -y
if [ $? -ne 0 ]; then
    dnf install nginx -y
    VALIDATE $? "NGINX"
else
    echo -e "NGINX is already installed ....$Y SKIPPING $W" | tee -a $LOG_FILE
fi

dnf list installed mongodb-mongosh -y
if [ $? -ne 0 ]; then
    dnf install mongodb-mongosh -y
    VALIDATE $? "MONGOSH"
else
    echo -e "MONGOSH is already installed ....$Y SKIPPING $W" | tee -a $LOG_FILE
fi