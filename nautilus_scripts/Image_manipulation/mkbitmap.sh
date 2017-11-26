#!/bin/bash
# NAUTILUS SCRIPT
# Ubuntu 12.04 Precise Pangolin
# Make bitmap of images using mkbitmap
makebitmap ()
{
# GET LIST OF FILES TO PROCESS
	# using nautilus script variable with correct space handling
	IFS=$'\n' read -d '' -r -a filelist < <(printf '%s\n' "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS"); unset $IFS

	# or: using filelist from folder
#	IFS=$'\n' read -d '' -r -a filelist < <(find -iname "*.jpg" | sort); unset $IFS # for testing
#set -x 

element_count=${#filelist[*]}
counter=1

# PROCESS FILES FROM FILELIST
for file in "${filelist[@]}"; do
	echo -ne "processing file $counter of $element_count..."\\r
	# convert files
	if [ "${file##*.}" != "pnm" ] && [ "${file##*.}" != "pbm" ]; then
		convert "$file" "${file%.*}.pnm"
		mkbitmap "${file%.*}.pnm"
	else
		mkbitmap "$file"
	fi
	let "counter = $counter + 1"
done
#set +x
}
# run the script in the terminal window
export -f makebitmap
# leave terminal open
gnome-terminal --execute bash -c "makebitmap ; bash"
