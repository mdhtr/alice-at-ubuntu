#!/bin/bash
# NAUTILUS SCRIPT
# automatically splits pdf file to multiple pages based on given block size, and renames the files using the original filename plus datestamp

# read files
IFS=$'\n' read -d '' -r -a filelist < <(printf '%s\n' "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS"); unset $IFS

# process files
for file in "${filelist[@]}"; do

	# variables
	blocksize=3 # ADD BLOCK SIZE MANUALLY HERE
	blocks=()
	filename=${file%.pdf} # remove extension from filename

	# calculate page range blocks
	pagecount=`pdfinfo $file | grep "Pages" | awk '{ print $2 }'` 
	let setcount=$pagecount/$blocksize 
	for (( setindex=1; setindex<=$setcount; setindex+=1 )); do

		if [[ $setindex -lt $setcount ]]; then
			let lastpage=$setindex*$blocksize
			let firstpage=$lastpage-$blocksize+1

		elif [[ $setindex -eq $setcount ]]; then # handle last page
			let lastpage=$pagecount
			let firstpage=$setindex*$blocksize-$blocksize+1

		fi
		blocks+=("$firstpage-$lastpage")
	done

	# process ranges to output
	for block in "${blocks[@]}"; do
		let "datestamp =`date +%s%N`" # to avoid overwriting with same new name
		pdftk $file cat $block output "$filename $datestamp.pdf"
	done
done
