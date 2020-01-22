#!/bin/sh

echo "$(tput bold)Building lightdm-eh8"
tput sgr0

# Removes old installs.
THEME_INSTALL_DIR="/usr/share/lightdm-webkit/themes/eh8"

if [ -d "$THEME_INSTALL_DIR" ]; then
    echo "Removing old copy of LightDM theme..."
    sudo rm -rf "$THEME_INSTALL_DIR"
    echo "Done."
fi

# Copies over default wallpapers.
echo "Copying over default images/backgrounds..."
[ -d ./src/assets/images ] && rm -rf ./src/assets/images
mkdir -p ./src/assets/images
cp -rf ./src/assets/default_images/* ./src/assets/images

# Copies over wallpapers.
WALL_DIRS="\
Pictures/Wallpapers
Pictures/wallpapers
Pictures/Wallpaper
Pictures/wallpaper"

setopt sh_word_split 2>/dev/null
IFS_OLD="$IFS"
IFS="
"
for wall_dir in $WALL_DIRS; do
    if [ -d "$HOME/$wall_dir" ]; then
        echo "Copying backgrounds from ~/$wall_dir..."
        cp "$HOME/$wall_dir/"* ./src/assets/images >/dev/null 2>&1
        sudo cp ./src/assets/images/* /usr/share/backgrounds >/dev/null 2>&1
        echo "Done."
        break
    fi
done

IFS="$IFS_OLD"

# Check if npm is installed.
NPM="$(command -v npm)"

if [ -z "$NPM" ]; then
    echo "\`npm\` is not installed."
    echo "Exiting..."
    exit
fi

# Install packages.
echo "Installing npm packages..."
$NPM install
echo "Done."

# `npm` build.
echo "Running Vue setup..."
sudo rm -rf ./dist >/dev/null 2>&1
$NPM run-script build
echo "Done"

# Build archive.
echo "Building directory..."
cd ./dist || exit 1
tar zcvf ../lightdm-eh8.tar.gz ./*
cd ../ || exit 1
sudo mkdir -p "$THEME_INSTALL_DIR"
sudo mv ./lightdm-eh8.tar.gz "$THEME_INSTALL_DIR" 
echo "Done"

# Decompressing.
echo "Entering directory and running final decompression..."
cd "$THEME_INSTALL_DIR" || exit 1
sudo tar xvf lightdm-eh8.tar.gz
echo "Done"

echo
echo "$(tput bold)--- NOTE ---$(tput sgr0)"
echo "  Remember to edit your lightdm config files accordingly:"
echo "  In \`/etc/lightdm/lightdm.conf\`:$(tput setaf 3)"
echo "      [Seat:*]"
echo "      greeter-session=lightdm-webkit2-greeter"
tput sgr0
echo "  In \`/etc/lightdm/lightdm-webkit2-greeter.conf\`:$(tput setaf 3)"
echo "      [greeter]"
echo "      webkit_theme=eh8"
tput sgr0
echo "$(tput bold)------------$(tput sgr0)"
echo 
echo "All done!"
