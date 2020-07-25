#!/bin/sh

# A simple script that prints out the characters of the string
read -p "Enter your name: " name
characters=${#name}
i=0

while [ $i -lt $characters ]
do

    echo ${name:$i:1}
    i=$(( $i + 1 ))

done