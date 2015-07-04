#!/bin/bash          

#Note: Input dir should not have trailing slash

#Initialize
set -x
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

# Set defaults
defaultSize=640

# Create temp directory
dirToProcess="$1"
tempDir="$1-temp"
mkdir "$tempDir"

# Copy files to temp dir
cp -r "$dirToProcess/." "$tempDir"

#Resize images
dir="$tempDir/*"
for i in $dir;
do 
	sips -Z $defaultSize $i;
	#echo "$i\n";
done

# Convert images to GIF
dir="$tempDir/*"
for i in $dir; 
do 
	sips -s format gif $i --out "$i.gif";
	rm $i;
done

# Convert images to animated GIF
dir="$tempDir/*"
gifsicle --delay 15 --loopcount=forever $dir > $2

# Cleanup
rm -r "$tempDir"

# End script
IFS=$SAVEIFS
