cd shared

git clone https://github.com/pulse-browser/browser

icon_id="com.fushra.browser"
icon_repo_path="browser/configs/branding"

function icon {
  local size="$1x$1"
  local brand=$2
  local append=$3

  echo "Icon: $size"

  # Initialise dirs
  mkdir -p "icons/$brand/hicolor/$size/apps/"
  mkdir -p "icons/$brand/appdir/$size/"
  # Download files to the correct dir
  cp "$icon_repo_path/$brand/logo$1.png" "icons/$brand/hicolor/$size/apps/$icon_id$append.png"
  cp "$icon_repo_path/$brand/logo$1.png" "icons/$brand/appdir/$size/$icon_id$append.png"
}

function branding_icon {
  local brand=$1
  local append=$2
  
  icon 16 $brand $append
  icon 22 $brand $append
  icon 24 $brand $append
  icon 32 $brand $append
  icon 48 $brand $append
  icon 64 $brand $append
  icon 128 $brand $append
  icon 256 $brand $append
}

branding_icon "alpha" ".alpha"
branding_icon "beta" ".beta"
branding_icon "stable" ""

rm -rf browser
