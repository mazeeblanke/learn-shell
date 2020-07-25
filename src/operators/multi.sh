#!/bin/sh

# When creating/initializing a variable, remember to not add space between the '=' and the value/variable name
number1=100
number2=20

# Subract two numbers
echo "#### Multiplication section ####"
echo $((3 * 7))
echo $(( 3*7 ))
expr 3 \* 6 # the slash is needed
expr $number1 \* $number2
echo $(( number1 * number2 )) # without the echo command, the expression will be processed as a command
echo "#########################"