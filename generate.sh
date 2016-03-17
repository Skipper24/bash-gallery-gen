#!/bin/bash
# Bash Generated HTML Wallpaper Gallery
# NASA Nov-13

# Run this script to update thumbnails/html file
# Requires imagemagik's convert
# Create a "thumbs" subdir in you wallpaper directory

wallsdir="walls"
walls=( "$wallsdir"/* ) # filename + path
wallfile=( "${walls[@]##*/}" ) # just filename
wallnumber=${#walls[*]}
wallnumber=$((wallnumber-1)) # number of walls without thumbs dir

# echo image names
# for a in ${wallfile[*]}
# do
# 	if [ ${a: -6} != ".thumb" ]
# 	then
# 		echo $wallsdir/$a
# 	fi
# done
# echo $wallnumber

genThumbs() # generate thumbnails
{
	for i in ${wallfile[*]}
	do
		if [ $i != "thumbs" ]
		then
			if [ ${i: -6} != ".thumb" ]
			then
				th="$wallsdir/thumbs/${i}.thumb"
				if [ ! -f "$th" ]
				then
					echo "${i}: creating thumbnail..."
					/usr/bin/convert -thumbnail 200x200 $wallsdir/$i $wallsdir/thumbs/${i}.thumb
				fi
			fi
		fi
	done
}

genTable() # generate gallery html
{
	echo "$wallnumber images as of "
	date +"%B %d %Y"
	echo "<br>"
	for item in ${wallfile[*]}
	do
		if [ $item != "thumbs" ]
		then
			thumbnail="${wallsdir}/thumbs/${item}.thumb"
    		echo "<a href=\"${wallsdir}/${item}\"><img src=\"${thumbnail}\"></a>"
    	fi
	done
}

writetohtml() # html template
{
	echo "<!DOCTYPE html>"
	echo "<html>"
	echo "<head>"
	echo "<title>Bash Generated Wallpaper Gallery</title>"
	echo "<link rel="stylesheet" type="text/css" href="style.css">"
	echo "</head>"
	echo "<body>"
	echo "<center><img src=\"abraxas.png\" style=\"border: 0px;\"></center>"
	echo "<center>"
	genTable
	echo "<br><img src=\"abraxas-seizure2.gif\" style=\"border: 0px;\">"
	echo "</center>"
	echo "</body>"
	echo "</html>"
}

rm index.html
writetohtml > index.html # write to html file
genThumbs # generate thumbnails
