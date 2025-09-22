#!/bin/bash

#DATE=$(date)

START_TIME=$(date +%s)
sleep 10
END_TIME=$(date +%s)

TOT_TIME = ($END_TIME-$START_TIME)
echo "Timestaamp Executed: $TOT_TIME"
