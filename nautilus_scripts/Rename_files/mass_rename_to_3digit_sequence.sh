#!/bin/bash
# NAUTILUS SCRIPT
# rename filename-sorted files sequentially to "000.ext"
########


# read files from Nautilus Script Selected File Paths
IFS=$'\n' read -d '' -r -a filelist < <(printf '%s\n' "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS"); unset $IFS
# sort input array
IFS=$'\n' sorted=($(sort <<<"${filelist[*]}")); unset $IFS

# read file-base-name from user input
#echo -n "indicate output file-base-name (w/o spaces & w/o extension): "; read basename

# todo: could read starting count number too. and seq amount too. both default to 1.
n=1 # start count

# process files
for file in "${sorted[@]}"; do
	extension="${file##*.}"
#	name="${file%.*}"
#	mv "$file" `printf "$basename" "-"``printf "%03d" "$n"`.$extension
	mv "$file" `printf "%03d" "$n"`.$extension
	n=$(($n+1)) # increase count
done
