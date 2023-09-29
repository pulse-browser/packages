#!/bin/bash

set -o errexit  # abort on nonzero exitstatus
set -o nounset  # abort on unbound variable
set -o pipefail # don't hide errors within pipes

# The first argument is the branding category
category=$1

# Collect the contant paths
repo=$(realpath ../repo/flatpak)
gpgKey="68070A3C9B5A79C21B76040AB671946A609089F2"

# Update the (alpha) build's metainfo
# TODO: This should work for all categories
node ./updateMetainfo.js

(
  cd "$category"
  rm pulse-browser.tar.bz2 || true # We do not care about failues to delete
  wget https://pulsebrowser.app/api/download\?platform\=linux\&channel\=$category -O pulse-browser.tar.bz2
  flatpak-builder --force-clean build-dir com.fushra.browser.yml

  echo
  echo "Building repo"
  flatpak build-export "$repo" build-dir "$category"

  echo
  echo "Signing the repository"
  flatpak build-sign "$repo" --gpg-sign=$gpgKey --gpg-homedir=~/.gpg
  flatpak build-update-repo "$repo" --gpg-sign=$gpgKey --gpg-homedir=~/.gpg
  gpg2 --homedir=~/.gpg --export $gpgKey >"$repo"/pulse-browser.gpg
)
