#!/bin/sh
# Rename files to the scheme: 000-001.ext

# extension
ext=pbm

# beginning numbers
z=0
e=1

for i in `find -iname "*.$ext" | sort`
do
	mv $i `printf "page_"``printf "%03d" "$z"``printf "-"``printf "%03d" "$e"`.$ext
	z=$(($z+2))
	e=$(($e+2))
done
echo "done"
