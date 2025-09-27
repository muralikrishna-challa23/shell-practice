#!/bin/bash

echo "All Parameters/Arguments::$@"
echo "All Parameters/Arguments::$*"
echo "File name executed::$0"
echo "Current directory::$PWD"
echo "home directory of executed user::$HOME"
echo "Who executed the script::$USER"
echo "PID of script executed::$$"
sleep 10 &
echo "Last backgroud run command::$!"
echo "Last executed command status::$?"
echo "Number of command-line arguments::$#"
echo "Internal Field Seperator, How shell splits strings into fields::$IFS"
echo "Flags are set in the shell::$-"
echo "Last argument provided to the previous command::$_"