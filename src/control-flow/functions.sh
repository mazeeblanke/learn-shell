#!/bin/sh

# In shell, avoid naming variables or functions with hypens
function do_stuff () {
    echo "I just wanna do some crazy stuffs..."
    echo "yeah, I will"
    echo "and here comes the arguments ", $1 $2
}


do_stuff vee 3