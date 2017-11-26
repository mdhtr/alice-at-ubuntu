#!/bin/bash
# rename all files in the actual directory 
# by changing the space character to underscore

ls | while read -r FILE
do
    mv -v "$FILE" `echo $FILE | tr ' ' '_' `
done
