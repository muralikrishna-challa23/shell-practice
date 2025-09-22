#!/bin/bash

#DATE=$(date)

START_TIME=$(date +%s)
sleep 10
END_TIME=$(date +%s)

echo "Timestaamp Executed: $(($END_TIME-$START_TIME))"
