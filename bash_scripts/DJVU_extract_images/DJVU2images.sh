#!/bin/bash
#Ubuntu 10.04 Lucid Lynx

#Put this script file in a directory with all the djvu-s you want to extract and run it in terminal.
#All the DJVU-s in this folder will be extracted to PNM-s.

### Select files to process
#defining the filelist
filelist=(`find -iname '*.djvu' | sort`)
#counting the files in the filelist
element_count=${#filelist[*]}
echo "alltogether $element_count djvu will be processed"

#process only 1 file at a time:
counter=1
echo "processing file:"
for i in "${filelist[@]}"
do
echo -ne "$element_count/$counter"\\r

#Get the number of pages from input file
pagecount=`djvused -e n $i`
#Set a filelist for the pages
	for (( filelist=1; filelist<=$pagecount; filelist+=1 ))
	do
	#Extract with DDJVU
	ddjvu -format=pnm -page=$filelist $i file_$counter.page_$filelist.pnm
	#Or use DjvuPs to extract PS from DJVU the same way:
	#djvups -page=$filelist $i file_$counter.page_$filelist.ps
	done
let "counter = $counter + 1"
done

echo DONE.
