#!/bin/bash
# NAUTILUS SCRIPT

massrename ()
{
# read files
IFS=$'\n' read -d '' -r -a filelist < <(printf '%s\n' "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS"); unset $IFS

element_count=${#filelist[*]}
counter=1

# user input contrast-stretch 
echo -n "rename prefix should be: "; read renameprefix

# process files
for file in "${filelist[@]}"; do
    echo -ne "processing file $counter of $element_count..."\\r
    
    filepath="${file%/*}"
    filename="${file##*/}"

    mv $file "$filepath""/""$renameprefix""$filename"
	
	let "counter = $counter + 1"
done

echo "Process finished. You can now close this window."
}
# run the script in the terminal window
export -f massrename
# leave terminal open
gnome-terminal --execute bash -c "massrename"
