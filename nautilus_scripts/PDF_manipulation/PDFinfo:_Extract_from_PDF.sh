#!/bin/sh
# NAUTILUS SCRIPT
# Extract info file from pdf to be edited by hand and then applied back to the pdf with the other script.
i=$@
exec pdftk $i dump_data output ${i%%.pdf}_info.txt

