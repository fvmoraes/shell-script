#!/bin/bash
#
# Written by Franklin Moraes.
# It is used to read a user-specified text file and count as words contained in it in another file.

echo "Enter the absolute reference of the file you want to read."
read inputFile

# READ THE ARCHIVE | BREAK THE LINE OF ALL WORDS | ORGANIZES BY ALPHABETICAL ORDER (WITHOUT SENSITIVE CASE) | JUST BRING WORDS WITH THREE CHARACTERS
# | REMOVE POINTS FROM WORDS | DO THE REPEAT COUNT (WITHOUT CASE SENSITIVE) | ORGANIZES AGAIN, BUT FOR DECLINING NUMBERS
# | SHOW THE 15 MOST USED WORDS | CREATE outputFile.txt
cat $inputFile | xargs -n 1 | sort -f | grep ... | egrep -o '\w+' | uniq -c -i | sort -n -r | head -n 15 >> outputFile.txt
