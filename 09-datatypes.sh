#!/bin/bash

NUMBER1=100
NUMBER2=200

SUM=$(($NUMBER1+$NUMBER2))

echo "Sum is: $SUM"

NAME="DevOps"

SUM=0
echo "Sum is: $SUM"

SUM=$(($NUMBER1+$NUMBER2+$NAME))

echo "Name is: $NAME"
echo "Sum is: $SUM"

LEADERS=("Modi" "Trump" "Putin")
echo "Leaders are:: ${LEADERS[@]}"

echo "Leaders are:: ${LEADERS[0]}"
echo "Leaders are:: ${LEADERS[1]}"

echo "Leaders are:: ${LEADERS}"

