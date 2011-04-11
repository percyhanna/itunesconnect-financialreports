#!/bin/bash
dir=`dirname "$0"`

for text_file in "$@"
do
	# handle .gz files as well
	echo Processing $text_file...
	ext="${text_file#*.}"
	if [[ "$ext" == "txt.gz" ]]; then
		gunzip "$text_file"
		text_file="${text_file/.txt.gz/.txt}"
	fi
	
	# get base file name and alternate extensions
	html="${text_file/.txt/.html}"
	pdf="${text_file/.txt/.pdf}"
	
	# convert to html
	"$dir"/itunesconnect2html.rb "$text_file" > /dev/null
	
	# convert to pdf, landscape mode
	/System/Library/Printers/Libraries/convert -f "$html" -o "$pdf" -a landscape 2> /dev/null
	
	# remove html file
	rm "$html"
done
