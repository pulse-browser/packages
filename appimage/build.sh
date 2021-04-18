cd appimage

if [ ! -f "linuxdeploy.AppImage" ]; then
    echo "Downloading linuxdeploy"
    wget https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage -O linuxdeploy.AppImage -q
    chmod +x ./linuxdeploy.AppImage
fi

if [ ! -f "dot.tar.bz2" ]; then
    echo "Downloading latest dot linux binary"
    node ./download.js
fi

if [ ! -d dot/ ]; then
    echo "Extracting binary"
    tar -xvf dot.tar.bz2 > /dev/null
fi



echo "Copying shared resources"
cp -r ../shared/icons/appdir ./icons


# echo "Compiling execution binary"
# shc -f dot-browser.sh -o dot-browser



echo "Setting up libary paths"
# Backup old library path
LD_LIBRARY_PATH_ORIGINAL=$(echo $LD_LIBRARY_PATH)
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$(pwd)/dot/"



echo "Linux Deploy"
# Clean up any potential leftover
rm -rf appdir

# Create folders
mkdir -p appdir/usr/lib/

# Copy files
cp -r dot/ appdir/usr/
mv appdir/usr/dot appdir/usr/bin
cp dot/dot-bin appdir/usr/bin/dot-browser

# Build appdir
./linuxdeploy.AppImage -i icons/256x256/co.dothq.browser.png -i icons/128x128/co.dothq.browser.png -i icons/64x64/co.dothq.browser.png \
                        -d dot.desktop --appdir=appdir/ --output appimage

echo "Cleanup"
export LD_LIBRARY_PATH=LD_LIBRARY_PATH_ORIGINAL