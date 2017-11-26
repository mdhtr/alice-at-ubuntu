#!/bin/bash
# Rotates even and odd images in a directory differently

# image extension
ext=pbm

# specify even and odd files
odd=(`find -iname "*[1 3 5 7 9].$ext" | sort`)
even=(`find -iname "*[0 2 4 6 8].$ext" | sort`)

mogrify -rotate 270 ${odd[*]}

mogrify -rotate 90 ${even[*]}

echo "done"
