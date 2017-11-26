#!/bin/bash
# Crop even and odd images in a directory differently

# image extension
ext=pbm

# specify even and odd files
odd=(`find -iname "*[1 3 5 7 9].$ext" | sort`)
even=(`find -iname "*[0 2 4 6 8].$ext" | sort`)

mogrify -crop 728x1074+40+0 ${odd[*]}

mogrify -crop 728x1074+0+0 ${even[*]}

echo "done"
