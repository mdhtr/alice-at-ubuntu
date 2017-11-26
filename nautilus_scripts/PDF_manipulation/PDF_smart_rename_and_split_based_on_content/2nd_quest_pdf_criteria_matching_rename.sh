#!/bin/bash
# NAUTILUS SCRIPT
# automatically renames pdf file based on content maching a list of names

# read files
IFS=$'\n' read -d '' -r -a filelist < <(printf '%s\n' "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS"); unset $IFS

names=( "Aaa Aaa" "Bbb Bbb" "Ccc Ccc")

# process files
for file in "${filelist[@]}"; do
	# find name from names in the file
	foundname=''
	for name in "${names[@]}"; do
		testname=`pdftotext "$file" - | grep $name`
		if [[ $testname != "" ]]; then
			foundname=$name
			break
		fi
	done

	# rename file based on found name
	title=`pdftotext -f 1 -l 1 "$file" - | head -n 1`
	let "datestamp =`date +%s%N`"
	mv "$file" "${file%/*}/$foundname $title $datestamp.pdf"
done
