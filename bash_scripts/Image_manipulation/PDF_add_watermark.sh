#!/bin/bash
# Ubuntu 9.10 Karmic Koala
# Watermark PDF files
# process all pdf files in the current directory and add the same watermark to them

# specify watermark file
watermark="$HOME/watermark.pdf"

# specify files to process
lista=(`find -iname '*.pdf' | sort`)
#a print out number of files to be processed
element_count=${#lista[*]}
echo $element_count files will be processed

#watermarking
counter=1
echo watermarking input files
for i in "${lista[@]}"
do
echo -ne "$element_count/$counter"\\r
pdftk $i stamp $watermark output ${i%%.???}_wm.pdf
let "counter = $counter + 1"
done

echo DONE.
