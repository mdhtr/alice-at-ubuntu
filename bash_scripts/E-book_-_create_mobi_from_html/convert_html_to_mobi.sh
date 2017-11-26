#!/bin/bash
# convert HTML book file to MOBI

# REQUIREMENTS
# * install wineconsole
# * download kindlegen and ncxGen
# * put this script in the same folder as ncxGen.0.2.6.exe and kindlegen
# * create a folder in this folder called "book_to_be_converted"
# * put your HTML file in the book_to_be_converted directory

# USAGE
# * modify the filename and metadata in this script to match your file
# * modify the TOC extraction part of the script as needed, based on the ncxgen manual section below

# NCXGEN MANUAL
#ncxgen [options] filename
#  -a, --all                  Create both html ToC, ncx and opf files.
#  -q, --query=VALUE          The XPath query to find the ToC items. Use
#                               multiple times to add levels in the ToC.
#  -l, --level=VALUE          Number of levels to collapse to generate the NCX
#                               file - used with -ncx or -all.
#  -e                         Place the generated TOC at the end of the book
#      --toc-title=VALUE      Name of the Table of Contents
#      --author=VALUE         Author name.
#      --title=VALUE          Book title.
#  -v, --verbose              Turn on verbose output
#  -i                         Convert <PRE class='image'> tages to PNG images
#      --overwrite            Overwrite files without any prompt
#Example:
#         "ngen.exe -all -q "//h1" -q "//h2[@class='toc']" source.xhtml"
#This expression will parse the xhtml file source.xhtml looking for the tag h1 and the tag h2 with an attribute class set to 'toc'. It will then create the html Table of Contents, the NCX Global Navigation file and the OPF file using the items found.

filename="book.html" # do not use spaces or dots in filename!!!

author="Unknown Author"
title="Unknown Title"
toc_title="Table of Contents"

wineconsole ncxGen.0.2.6.exe -a -q "//h1" -q "//h2" --author="$author" --title="$title" --toc-title="$toc_title" ./book_to_be_converted/$filename 

./kindlegen ./book_to_be_converted/${filename%.*}.opf
