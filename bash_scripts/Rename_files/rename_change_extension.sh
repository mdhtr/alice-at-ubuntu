#!/bin/sh
# change extension of files

from=JPG
to=jpg

for i in `find -name "*.$from" | sort`
do
	mv $i "${i%.*}".$to
done
