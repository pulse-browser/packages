icon_id="co.dothq.browser.flatpak"

function icon {
  local size="$1x$1"
  local path="$2"

  echo "Icon: $size"

  # Initialise dir
  install -d "/app/share/icons/hicolor/$size/apps/"
  # Download files to the correct dir
  cp "$path" "/app/share/icons/hicolor/$size/apps/$icon_id.png"
}

icon_repo_path="src/common/browser/branding/dot"

icon 16 "$icon_repo_path/default16.png"
icon 22 "$icon_repo_path/default22.png"
icon 24 "$icon_repo_path/default24.png"
icon 32 "$icon_repo_path/default32.png"
icon 48 "$icon_repo_path/default48.png"
icon 64 "$icon_repo_path/default64.png"
icon 128 "$icon_repo_path/default128.png"
icon 256 "$icon_repo_path/default256.png"