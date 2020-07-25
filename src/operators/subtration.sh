#!/bin/sh

# When creating/initializing a variable, remember to not add space between the '=' and the value/variable name
number1=100
number2=20

# Subract two numbers
echo "#### Subtration section ####"
echo $((3-7))
echo $(( 3-7 ))
expr 3 - 6 # doea not need 'echo' command to print stuffs out to the terminal
expr $number1 - $number2 # when performing an operation add the $ sign, when assigning remove it
echo $(( number1 - number2 )) # without the echo command, the expression will be processed as a command
echo "#########################"