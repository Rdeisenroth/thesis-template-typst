#!/bin/sh

# ensure the tuda_logo.svg is in this directory
# we need to invert the colors for dark mode
# Remove background and set all elements to white using Inkscape's command-line options
# copy to tuda_logo-dark.svg
cp tuda_logo.svg tuda_logo-dark.svg
# remove background
sed -i 's/rgb(100%, 100%, 100%)/none/g' tuda_logo-dark.svg
# color everything white
sed -i -E 's/rgb\([^)]*\)/rgb(255, 255, 255)/g' tuda_logo-dark.svg
