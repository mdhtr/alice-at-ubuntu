#!/bin/bash
# NAUTILUS SCRIPT
# automatically splits pdf file to multiple pages based on search criteria while renaming the output files using the search criteria and some of the pdf text.

# read files
IFS=$'\n' read -d '' -r -a filelist < <(printf '%s\n' "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS"); unset $IFS

# process files
for file in "${filelist[@]}"; do
	pagecount=`pdfinfo $file | grep "Pages" | awk '{ print $2 }'`
	# MY SEARCH CRITERIA is a 10 digit long ID number that begins with number 8: 
	storedid=`pdftotext -f 1 -l 1 $file - | egrep '8?[0-9]{9}'`
	pattern=''
	pagetitle=''
	datestamp=''

	for (( pageindex=1; pageindex<=$pagecount; pageindex+=1 )); do

		header=`pdftotext -f $pageindex -l $pageindex $file - | head -n 1`
		pageid=`pdftotext -f $pageindex -l $pageindex $file - | egrep '8?[0-9]{9}'`
		let "datestamp =`date +%s%N`" # to avoid overwriting with same new name

		# match ID found on the page to the stored ID
		if [[ $pageid == $storedid ]]; then
			pattern+="$pageindex " # adds number as text to variable separated by spaces
			pagetitle+="$header+"

			if [[ $pageindex == $pagecount ]]; then	#process last output of the file	
				pdftk $file cat $pattern output "$storedid $pagetitle $datestamp.pdf"
				storedid=0
				pattern=''
				pagetitle=''
			fi
		else 
			#process previous set of pages to output
			pdftk $file cat $pattern output "$storedid $pagetitle $datestamp.pdf"
			storedid=$pageid
			pattern="$pageindex "
			pagetitle="$header+"
		fi
	done
done
