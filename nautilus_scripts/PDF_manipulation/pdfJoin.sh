#!/bin/bash
# NAUTILUS SCRIPT
# Ubuntu 12.04 Precise Pangolin
# Join selected PDF files with pdfjoin
joinpdf ()
{
# GET LIST OF FILES TO PROCESS
	# using nautilus script variable with correct space handling
	IFS=$'\n' read -d '' -r -a filelist < <(printf '%s\n' "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS"); unset $IFS

	# or: using filelist from folder
#	IFS=$'\n' read -d '' -r -a filelist < <(find -iname "*.jpg" | sort); unset $IFS # for testing
#set -x 

# MAKE MULTIPAGE PDF
# sort array (use multi-digit numbering like '001', '002' to get proper sorting!) 
IFS=$'\n' sorted=($(sort <<<"${filelist[*]}")); unset $IFS
#join pdfs
echo -ne \\n"joining pdfs"\\n
pdftk "${sorted[@]}" cat output ${PWD##*/}.pdf

echo "done"
#set +x
}
# run the script in the terminal window
export -f joinpdf
# leave terminal open
gnome-terminal --execute bash -c "joinpdf ; bash"
