#!/bin/bash

# Declare and initailize variable to 10
# always make sure not to separate the variable from the value or '=' e.g i = 10 is wrong
i=10

# while variable is greater than 0, print variable
while [ $i -gt 0 ]
do
    echo "The variable is ", $i
    i=$(( $i - 1 ))
done