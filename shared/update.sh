cd shared

git clone https://github.com/fushra/browser

icon_id="com.fushra.browser.desktop"
icon_repo_path="browser/configs/branding/stable"

function icon {
  local size="$1x$1"

  echo "Icon: $size"

  # Initialise dirs
  mkdir -p "icons/hicolor/$size/apps/"
  mkdir -p "icons/appdir/$size/"
  # Download files to the correct dir
  cp "$icon_repo_path/logo$1.png" "icons/hicolor/$size/apps/$icon_id.png"
  cp "$icon_repo_path/logo$1.png" "icons/appdir/$size/$icon_id.png"
}

icon 16
icon 22
icon 24
icon 32
icon 48
icon 64
icon 128
icon 256

rm -rf browser

# Copy the download script into each folder that requires it
printf "// This file was copied from shared/scripts. Edit it there instead\n$(<scripts/download.js)" > ../flatpak/download.js
