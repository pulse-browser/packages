# This file builds a flatpak file for Dot Browser
# https://docs.flatpak.org/en/latest/first-build.html

echo "Install runtime and SDK"
echo "======================="
# -y assumes yes
flatpak install flathub org.gnome.Platform//3.38 org.gnome.SDK//3.38 -y

clear
echo "Downloading latest linux binary"
echo "==============================="
# TODO: This needs to be far more dynamic
wget https://github.com/dothq/browser-desktop/releases/download/87.0-720629329/dot-87.0.tar.bz2

clear
echo "Extract linux binary"
echo "===================="
tar -xf dot-87.0.tar.bz2