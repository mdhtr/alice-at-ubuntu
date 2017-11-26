#!/bin/sh
# Rename files to the scheme: 000.ext

# extension
ext=pbm

# beginning number
z=1


for i in `find -iname "*.$ext" | sort`
do
	mv $i `printf "page"``printf "%03d" "$z"`.$ext
	z=$(($z+1))
done
echo "done"
