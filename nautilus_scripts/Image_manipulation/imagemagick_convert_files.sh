#!/bin/bash
# NAUTILUS SCRIPT
# Do any kind of transformation with imagemagick on selected files
domagick ()
{
# read files
IFS=$'\n' read -d '' -r -a filelist < <(printf '%s\n' "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS"); unset $IFS

element_count=${#filelist[*]}
counter=1

# user input contrast-stretch 
echo -n "input imagemagick -options as you would regularry: "; read imagemagick
# user input postfix 
echo -n "input postfix for the modified files (defaults to '_m'): "; read postfix
if [[ $postfix == "" ]]; then
	postfix="_m"
fi

# process files
for file in "${filelist[@]}"; do
	echo -ne "processing file $counter of $element_count..."\\r

	convert $file $imagemagick "${file%.*}""$postfix"."${file##*.}"

	let "counter = $counter + 1"
done
}
# run the script in the terminal window
export -f domagick
# leave terminal open
gnome-terminal --execute bash -c "domagick"
