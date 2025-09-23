#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "ERROR::Please run this with root ccess"
    exit 1
 fi

 dnf install mysql -y

 if [ $? -ne 0 ]; then
    echo "ERROR:: Installing MYSQL is FAILURE"
    exit 1
 else
    echo "Installing MYSQL is SUCCESS"   
 fi

dnf install nginx -y

 if [ $? -ne 0 ]; then
    echo "ERROR:: Installing NGINX is FAILURE"
    exit 1
 else
    echo "Installing NGINX is SUCCESS"   
 fi

 dnf install mongodb-mongosh -y

 if [ $? -ne 0 ]; then
    echo "ERROR:: Installing MONGOSH is FAILURE"
    exit 1
 else
    echo "Installing MONGOSH is SUCCESS"   
 fi