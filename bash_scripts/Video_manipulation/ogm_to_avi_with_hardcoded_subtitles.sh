#!/bin/bash
# OGM to AVI with hardcoded subtitles

# process all files in the actual folder that match the criteria
lista=(`find -iname '*.ogm' | sort`)
# print out the number of files that will be processed
element_count=${#lista[*]}
echo $element_count ogm will be processed

counter=1
echo "ogm to avi with subs"
for j in "${lista[@]}"
do
echo -ne "$element_count/$counter"\\r
mencoder $j -aid 1 -sub ${j%%.???}.srt -o $j.avi -oac mp3lame -lameopts cbr=128 -ovc lavc -lavcopts vcodec=mpeg4:vbitrate=5000:mbd=2:trell
let "counter = $counter + 1"
done

echo DONE.
