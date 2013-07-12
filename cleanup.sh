#!/bin/bash
#
# cleanup.sh - clean up makepkg's trash
#
# Florian Dejonckheere <florian@floriandejonckheere.be>
#

# List of suffixes to search for. Suffixes with a trailing slash will be considered paths.
SUFFIX=('.tar.gz' '.tar.bz2' '.tar.xz' '.zip' 'src/' 'pkg/' '.cpp' '.c')

CLEAN=()

for SUF in ${SUFFIX[@]}; do
	TYPE="files"
	[[ "${SUF: -1}" == "/" ]] && TYPE="directories" && SUF=${SUF::-1}
	echo -e "\033[32mSearching for ${TYPE} with suffix ${SUF}\033[0m"
	for TRASH in $(find . -type ${TYPE::1} -iname '*'${SUF}); do
		echo -e "=> \033[1;31m$TRASH\033[0m"
		CLEAN=(${CLEAN[@]} $TRASH)
	done
done

[[ ${#CLEAN[@]} -eq 0 ]] && echo "Directory clean." && exit 0

echo -n "Continue? THIS WILL DELETE THE ABOVE FILES WITHOUT CONFIRMATION! (y/N) "
read -n 1 CONT
echo
if [[ "$CONT" == "y" ]]; then
	for TRASH in "${CLEAN[@]}"; do
		rm -rf "${TRASH}"
	done
fi
