icon_id="co.dothq.browser.nightly"
icon_repo_path="src/common/browser/branding/dot"

function icon {
  local size="$1x$1"

  echo "Icon: $size"

  # Initialise dir
  install -d "/app/share/icons/hicolor/$size/apps/"
  # Download files to the correct dir
  cp "$icon_repo_path/default$1.png" "/app/share/icons/hicolor/$size/apps/$icon_id.png"
}

icon 16
icon 22
icon 24
icon 32
icon 48
icon 64
icon 128
icon 256