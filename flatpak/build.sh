#!/bin/bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

# The first argument is the branding category
category=$1

# Collect the contant paths
repo=$(realpath ../repo/flatpak)
gpgKey="64844DAB0FEC1D9CE347CEC09080B1B929B33470"

(
  cd "$category"
  rm pulse-browser.tar.bz2
  wget https://pulsebrowser.app/api/download\?platform\=linux\&channel\=$category -O pulse-browser.tar.bz2
  flatpak-builder --force-clean build-dir com.fushra.browser.yml

  echo
  echo "Building repo"
  flatpak build-export "$repo" build-dir "$category"

  echo
  echo "Signing the repository"
  flatpak build-sign "$repo" --gpg-sign=$gpgKey --gpg-homedir=~/.gpg
  flatpak build-update-repo "$repo" --gpg-sign=$gpgKey --gpg-homedir=~/.gpg
  gpg2 --homedir=~/.gpg --export $gpgKey > "$repo"/pulse-browser.gpg
)
