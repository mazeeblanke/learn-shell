#!/bin/sh

read -p "Enter your name: " name

case ${#name} in
    1) echo "what kind of name is just " ${#name} "characters long";;
    2) echo "not bad";;
    3) echo "cute name";;
    *) echo "fuck you are long";;
esac    