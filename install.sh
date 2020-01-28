#!/bin/sh

ARROW="$(tput setaf 4)$(tput bold)->$(tput sgr0)"

echo "$(tput bold)Building Saluto"
tput sgr0

# Removes old installs.
THEME_INSTALL_DIR="/usr/share/lightdm-webkit/themes/saluto"

if [ -d "$THEME_INSTALL_DIR" ]; then
    echo "$ARROW Removing old copy of LightDM theme..."
    echo "  You might need a password for this."
    sudo rm -rf "$THEME_INSTALL_DIR"
    echo "Done."
fi

# Ask if we should rebuild the images/ directory.
answer=y
if [ -d ./src/assets/images ]; then
    echo
    echo "Looks like we already have your wallpapers..."
    printf "  Would you like to rebuild this wallpaper folder? [y/N]: "
    read -r answer
    [ -z "$answer" ] && answer=n
fi

# Copies over default images.
if [ "$answer" = y ] || [ "$answer" = Y ]; then
    echo
    echo "$ARROW Copying over default images/backgrounds..."
    [ -d ./src/assets/images ] && rm -rf ./src/assets/images
    mkdir -p ./src/assets/images
    cp -rf ./src/assets/default_images/* ./src/assets/images

    # Copies over wallpapers.
    WALL_DIRS="\
Pictures/Wallpapers
Pictures/wallpapers
Pictures/Wallpaper
Pictures/wallpaper"

    WALL_ASSETS="./src/assets/images/wallpapers"

    setopt sh_word_split 2>/dev/null
    IFS_OLD="$IFS"
    IFS="
"
    for wall_dir in $WALL_DIRS; do
        if [ -d "$HOME/$wall_dir" ]; then
            echo "  $ARROW Copying backgrounds from ~/$wall_dir..."
            cp "$HOME/$wall_dir"/* "$WALL_ASSETS" >/dev/null 2>&1
            echo "Done."
            break
        fi
    done

    # Pre-blur wallpapers.
    MAGICK="$(command -v convert)"

    if [ -z "$MAGICK" ]; then
        echo "ImageMagick \`convert\` not installed."
        echo "Please install ImageMagick for blurring."
        echo "Exiting..."
        exit
    fi

    mkdir -p "$WALL_ASSETS/blurred"
    echo "$ARROW Blurring wallpapers..."
    for wall in "$WALL_ASSETS"/*; do
        if [ -f "$wall" ]; then
            wall_base="$(basename "$wall")"
            echo "  $ARROW Converting $wall_base..."
            $MAGICK -quiet -regard-warnings \
                "$WALL_ASSETS/$wall_base" -resize 1500 \
                -filter Gaussian -resize '50%' \
                -define filter:sigma=6 -resize '200%' \
                "$WALL_ASSETS/blurred/$wall_base"
        fi
    done

    # Copy to /usr/share.
    echo "$ARROW Copying wallpapers to /usr/share/backgrounds..."
    echo "  You might need to give your password for this one."
    sudo cp -rf "$WALL_ASSETS"/* /usr/share/backgrounds

    IFS="$IFS_OLD"
fi

# Check if npm is installed.
NPM="$(command -v npm)"

if [ -z "$NPM" ]; then
    echo "\`npm\` is not installed."
    echo "Exiting..."
    exit
fi

# Install packages.
if [ ! -d ./node_modules ]; then
    echo "$ARROW \`node_modules\` not found, installing packages..."
    $NPM install
    echo "Done."
else
    echo "$ARROW \`node_moudles\` found, skipping running \`npm install\`."
fi

# `npm` build.
echo "$ARROW Running Vue setup..."
sudo rm -rf ./dist >/dev/null 2>&1
$NPM run-script build
echo "Done"

# Build archive.
echo "$ARROW Building directory..."
cd ./dist || exit 1
tar zcf ../lightdm-saluto.tar.gz ./*
cd ../ || exit 1
sudo mkdir -p "$THEME_INSTALL_DIR"
sudo mv ./lightdm-saluto.tar.gz "$THEME_INSTALL_DIR"
echo "Done"

# Decompressing.
echo "$ARROW Entering directory and running final decompression..."
cd "$THEME_INSTALL_DIR" || exit 1
sudo tar xf lightdm-saluto.tar.gz
echo "Done"

echo
echo "$(tput bold)--- NOTE ---$(tput sgr0)"
echo "  Remember to edit your lightdm config files accordingly:"
echo "  - In \`/etc/lightdm/lightdm.conf\`:$(tput setaf 3)"
echo "      [Seat:*]"
echo "      greeter-session=lightdm-webkit2-greeter"
tput sgr0
echo "  - In \`/etc/lightdm/lightdm-webkit2-greeter.conf\`:$(tput setaf 3)"
echo "      [greeter]"
echo "      webkit_theme=saluto"
tput sgr0
echo "$(tput bold)------------$(tput sgr0)"
echo
echo "All done!"
