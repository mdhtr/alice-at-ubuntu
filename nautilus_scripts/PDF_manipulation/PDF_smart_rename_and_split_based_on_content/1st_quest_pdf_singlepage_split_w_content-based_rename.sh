#!/bin/bash
# NAUTILUS SCRIPT
# automatically splits pdf file to single pages while renaming the output files using the first three lines of the pdf

# read files
IFS=$'\n' read -d '' -r -a filelist < <(printf '%s\n' "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS"); unset $IFS

pagecount=1
datestamp=1

# burst and rename pages to separate files
for file in "${filelist[@]}"; do
	pagecount=`pdfinfo $file | grep "Pages" | awk '{ print $2 }'`
	for (( pageindex=1; pageindex<=$pagecount; pageindex+=1 )); do
		newname=`pdftotext -f $pageindex -l $pageindex $file - | head -n 3 | tr '\n' ' ' | cut -f1 -d"("`
		let "datestamp =`date +%s%N`" # to avoid overwriting with same new name
		pdftk $file cat $pageindex output "$newname"$datestamp.pdf
	done
done
