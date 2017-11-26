#!/bin/bash
# NAUTILUS SCRIPT
# Apply pdf info file on pdf.
# Extract the info file with the other script to make use of this script
i=$@
exec pdftk $i update_info ${i%%.pdf}_info.txt output ${i%%.pdf}_info.pdf
