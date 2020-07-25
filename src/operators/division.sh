#!/bin/sh

# When creating/initializing a variable, remember to not add space between the '=' and the value/variable name
number1=1009
number2=20

# Add two numbers
echo "#### Division section ####"
echo "3/7" | bc -l # needed to show decimal point
echo "$number1 / $number2" | bc -l
echo $(( number1 / number2 ))
echo "#########################"