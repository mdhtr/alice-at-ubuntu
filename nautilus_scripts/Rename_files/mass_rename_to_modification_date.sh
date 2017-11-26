#!/bin/bash
# NAUTILUS SCRIPT
# rename files based on last modification date
########
# for further modification of the date appearance:
# `stat -c %y $file` # output: "2015-04-28 20:30:18.478242499 +0200"
# `[...] | awk '{print $1"_"$2}'` # output: "2015-04-28_20:30:18.478242499"
# `[...] | awk 'BEGIN { FS="[-:._]" } { print $1 $2 $3 $4 $5 $6 $7}'` # output: "20150428203018478242499"
# $1: year 
# $2: month 
# $3: day 
# $4: hour 
# $5: minute 
# $6: second 
# $7: nanosecond
# put any kind of delimiter in between these, in double quote "" 
########

# read files from Nautilus Script Selected File Paths
IFS=$'\n' read -d '' -r -a filelist < <(printf '%s\n' "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS"); unset $IFS

# process files
for file in "${filelist[@]}"; do
	extension="${file##*.}"
#	name="${file%.*}"
	newname=`stat -c %y $file | awk '{print $1"-"$2}'| awk 'BEGIN { FS="[-:.]" } { print $1 $2 $3 $4 $5 $6 $7 }'`
	mv "$file" "$newname.$extension"

done


