# Pulse flatpak build utilities

## Install dependencies

```sh
flatpak install flathub org.freedesktop.Platform//21.08 org.freedesktop.Sdk//21.08 org.freedesktop.Platform.ffmpeg-full//21.08
flatpak install flathub org.mozilla.firefox.BaseApp//21.08 # From what I can tell, provides precompiled binaries for a bunch of stuff
```

## Download the latest linux artifacts and extract it

```sh
# Find the latest release in this list
gh release list -R pulse-browser/browser

# Download the linux binaries and extract them. Replace "alpha-2022-07-11" with
# whatever you want
gh release download alpha-2022-07-11 --pattern "*.tar.bz2" -R pulse-browser/browser
tar -xvf pulse-browser.linux.tar.bz2
```

## Building

```sh
flatpak-builder --user --install --force-clean build-dir com.fushra.browser.yml
```

## Running

```sh
flatpak run com.fushra.browser
```
