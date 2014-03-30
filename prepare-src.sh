#!/usr/bin/bash
#
# prepare-src.sh - downloads and prepares AUR packages
#
# Florian Dejonckheere <florian@floriandejonckheere.be>
#

[[ ! $1 ]] && echo "Usage: $0 PACKAGE [EXTRACT_DIR]" && exit 1

[[ $1 ]] && PKG=$(echo $1 | tr [:upper:] [:lower:])

DIR="$(pwd)/$2"

wget "https://aur.archlinux.org/packages/$(echo ${PKG} | cut -b -2)/${PKG}/${PKG}.tar.gz" -O "/tmp/${PKG}.tar.gz"
[[ ! -d "${DIR}" ]] && mkdir "${DIR}"
tar zxvf "/tmp/${PKG}.tar.gz" -C "${DIR}"
