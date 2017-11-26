#!/bin/bash
# NAUTILUS SCRIPT
# Ubuntu 12.04 Precise Pangolin
# Make relatively small size multi-page PDF from single pages book.
#########
### Convert
# - color and greyscale to color
# - black and white to black and white
### Possible input formats
# - any image format imagemagick can handle
### Method
# - 1. everything will be converted to PNM (color output) or PBM (b&w output)
# - 2. PNM/PBM will be converted to PS and from PS to PDF, and the single PDF files will be joined to a multi-page pdf.
### Possible parameters
# --keep-image --keep-ps --keep-pdf --keep-all : keep specified workfiles when finished
# --output [output pdf name] : give custom name to output
# --resize [%] : resize image to percentage
# --color-cover : keep a single cover image, when converting the rest to b&w
# --mkbitmap : convert to black-and-white
#########
makepdf ()
{
# GET LIST OF FILES TO PROCESS
# using nautilus script variable with correct space handling
IFS=$'\n' read -d '' -r -a filelist < <(printf '%s\n' "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS"); unset $IFS

# or: using filelist from folder
#	IFS=$'\n' read -d '' -r -a filelist < <(find -iname "*.jpg" | sort); unset $IFS # for testing
#set -x 

converted=() # temporary files
finalists=() # pdf-s to be joined

element_count=${#filelist[*]}
counter=1

# PROCESS FILES FROM FILELIST
for file in "${filelist[@]}"; do
	echo -ne "processing $file file $counter of $element_count..."\\r
	# get file basic values
#	extension="${file##*.}"
#	name="${file%.*}"

	# convert files if needed
	if [ "${file##*.}" != "pnm" ] && [ "${file##*.}" != "pbm" ]; then
		colorspace=`identify -verbose "$file" | egrep ^"  Type" | awk '{ print $2}'` # TrueColor Grayscale or Bilevel
		if [ $colorspace = "Bilevel" ]; then
			convert "$file" "${file%.*}.pbm"
			file="${file%.*}.pbm"
		else # keep color
			convert "$file" "${file%.*}.pnm"
			file="${file%.*}.pnm"
		fi
		converted+=("$file")
	fi

	# get geometry
#	width=`identify $file | awk '{ print $3}' | awk 'BEGIN { FS="x" } { print $1}'`
#	height=`identify $file | awk '{ print $3}' | awk 'BEGIN { FS="x" } { print $2}'`
	geometry=`identify -verbose "$file" | egrep ^"  Geometry" | awk '{ print $2}' | awk 'BEGIN { FS="+" } { print $1}'`

	# convert to ps
	convert "$file" "$file.ps"
	# convert to pdf
	ps2pdf12 -r72 -g$geometry "$file.ps" "${file%.*}.pdf"
	rm "$file.ps"
	file="${file%.*}.pdf"
	finalists+=("$file")

	let "counter = $counter + 1"
done

# MAKE MULTIPAGE PDF
# sort finalist array
IFS=$'\n' sorted=($(sort <<<"${finalists[*]}")); unset $IFS
#join pdfs
echo -ne \\n"joining pdfs"\\n
pdftk "${sorted[@]}" cat output ${PWD##*/}.pdf

# CLEAN UP
#remove temporary files
echo "removing temporary files"
for file in "${converted[@]}"
do
	rm "$file"
done

for file in "${sorted[@]}"
do
	rm "$file"
done
echo "done"
#set +x
}
# run the script in the terminal window
export -f makepdf
# leave terminal open
gnome-terminal --execute bash -c "makepdf ; bash"
