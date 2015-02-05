#!/usr/bin/bash
#
# prepare-src.sh - downloads and extracts AUR packages
#
# Florian Dejonckheere <florian@floriandejonckheere.be>
#

if [[ ! $1 ]]; then
	echo -e "\e[1;32mUsage: $0 PACKAGE ...\e[0m" 1>&2
	exit 1
fi

for ARG in $@; do
	PKG=$(echo ${ARG} | tr [:upper:] [:lower:])

	echo -en "\e[1;33mProcessing package ${PKG}... "
	wget --quiet "https://aur.archlinux.org/packages/$(echo ${PKG} | cut -b -2)/${PKG}/${PKG}.tar.gz" -O "/tmp/${PKG}.tar.gz" || 
	{
		echo -e "\e[0m\n\e[1;32mError: package ${PKG} not found.\e[0m"
		exit 1
	}
	echo -e "Done\e[0m"

	[[ ! -d "${PKG}" ]] && mkdir "${PKG}"
	echo
	tar zxvf "/tmp/${PKG}.tar.gz" -C "$(pwd)"
done
