#!/bin/bash
#
# cleanup.sh - clean up makepkg's trash
#
# Florian Dejonckheere <florian@floriandejonckheere.be>
#

# List of suffixes to search for. Suffixes with a trailing slash will be considered paths.
SUFFIX=('*.tar.gz' '*.tar.bz2' '*.zip' 'src/' 'pkg/')

CLEAN=()

for SUF in ${SUFFIX[@]}; do
	TYPE="f"
	[[ "${SUF}" == */ ]] && TYPE="d" && SUF=$(echo ${SUF} | head -c -2)
	echo "Searching for ${SUF}, type ${TYPE}"
	for TRASH in $(find . -type ${TYPE} -iname ${SUF}); do
		echo -e "=> \033[1;31m$TRASH\033[0m"
		CLEAN=(${CLEAN[@]} $TRASH)
	done
done

echo -n "Continue? THIS WILL RECURSIVELY DELETE (y/N) "
read -n 1 CONT
echo
if [[ "$CONT" == "y" ]]; then
	for TRASH in "${CLEAN[@]}"; do
		rm -ir "${TRASH}"
	done
fi
