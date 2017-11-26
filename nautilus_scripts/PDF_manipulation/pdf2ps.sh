#!/bin/bash
# NAUTILUS SCRIPT
# Extract PS files from multipage PDF with pdftops
makeps ()
{
# read files
IFS=$'\n' read -d '' -r -a filelist < <(printf '%s\n' "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS"); unset $IFS

# process files
for file in "${filelist[@]}"; do
	pagecount=`pdfinfo $file | grep "Pages" | awk '{ print $2 }'`
	for (( pageindex=1; pageindex<=$pagecount; pageindex+=1 )); do
		pdftops $file -f $pageindex -l $pageindex `printf "${file%.*}""-"``printf "%03d" "$pageindex"`.ps
	done
done
}
# run the script in the terminal window
export -f makeps
# leave terminal open
gnome-terminal --execute bash -c "makeps ; bash"
