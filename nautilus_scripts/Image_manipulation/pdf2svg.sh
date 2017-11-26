#!/bin/bash
# NAUTILUS SCRIPT
# Convert PDF file to SVG images

#get the filelist to process
	# using nautilus script variable with correct space handling
	IFS=$'\n' read -d '' -r -a filelist < <(printf '%s\n' "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS"); unset $IFS
	# or: using filelist from folder
	#IFS=$'\n' read -d '' -r -a filelist < <(find -iname "*.pdf" | sort); unset $IFS

# process files
#set -x
for file in "${filelist[@]}"; do
	#Get the number of pages from input file for processing
	pagecount=`pdfinfo $file | grep "Pages" | awk '{ print $2 }'`
	for (( counter=1; counter<=$pagecount; counter+=1 )); do
		pdf2svg "$file" page_$counter.svg $counter
	done
done
