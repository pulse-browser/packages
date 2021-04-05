# This file builds a flatpak file for Dot Browser
# https://docs.flatpak.org/en/latest/first-build.html

echo "Install runtime and SDK"
echo "======================="
# -y assumes yes
flatpak install flathub org.freedesktop.Platform//19.08 org.freedesktop.Sdk//19.08 -y

clear
echo "Downloading latest linux binary"
echo "==============================="
# TODO: This needs to be far more dynamic
wget https://github.com/dothq/browser-desktop/releases/download/87.0-717456043/dot-87.0.tar.bz2

clear
echo "Extract linux binary"
echo "===================="
tar -xf dot-87.0.tar.bz2