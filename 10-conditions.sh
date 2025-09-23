#!/bin/bash

NUMBER=$1

if [ [ -z $NUMBER] ]; then
   echo "Please provide value"
fi   

if [ $NUMBER -lt 10 ] ; then
    echo " The given number $NUMBER is less than 10"

else
    echo "The given number $NUMBER is greater than or equal to 10"
fi