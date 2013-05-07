#!/bin/bash
#
# cleanup.sh - clean up makepkg's trash
#
# Florian Dejonckheere <florian@floriandejonckheere.be>
#

# List of suffixes to search for. Suffixes with a trailing slash will be considered paths.
SUFFIX=('*.tar.gz' '*.tar.bz2' '*.zip' 'src/' 'pkg/')

for SUF in ${SUFFIX[@]}; do
	METHOD="name"
	[[ $(echo ${SUF} | tail -c 2) == "/" ]] && METHOD="path"
	echo "Searching for $SUF, with method $METHOD"
	for TRASH in $(find . -i${METHOD} "${SUF}"); do
		echo $TRASH
	done
done
