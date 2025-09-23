#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "ERROR::Please run this with root ccess"
    exit 1
 fi

VALIDATE() {
if [ $1 -ne 0 ]; then
    echo "ERROR:: Installing $2 is FAILURE"
    exit 1
 else
    echo "Installing $2 is SUCCESS"   
 fi
}

dnf list installed mysql -y
if [ $? -ne 0 ]; then
    dnf install mysql -y
    VALIDATE $? "MYSQL"
else
    echo "MYSQL is already installed"
fi

dnf list installed nginx -y
if [ $? -ne 0 ]; then
    dnf install nginx -y
    VALIDATE $? "NGINX"
else
    echo "NGINX is already installed"
fi

dnf list installed mongodb-mongosh -y
if [ $? -ne 0 ]; then
    dnf install mongodb-mongosh -y
    VALIDATE $? "MONGOSH"
else
    echo "MONGOSH is already installed"
fi