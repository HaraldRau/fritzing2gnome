#!/bin/bash

# Check if ImageMagick is installed
if ! command -v convert &> /dev/null; then
    echo "🔹 'convert' (ImageMagick) is not installed. Installing it now..."
    sudo apt update && sudo apt install -y imagemagick
fi

# Set input and output paths
ICON_SRC="fritzing.svg"
OUTPUT_DIR="."

# Check if the source file exists
if [ ! -f "$ICON_SRC" ]; then
    echo "Error: '$ICON_SRC' not found!"
    exit 1
fi

# Convert SVG to PNG in different sizes using ImageMagick
echo "Converting $ICON_SRC to PNG files..."
convert -background none "$ICON_SRC" -resize 64x64 "$OUTPUT_DIR/fritzing_64.png"
convert -background none "$ICON_SRC" -resize 128x128 "$OUTPUT_DIR/fritzing_128.png"
convert -background none "$ICON_SRC" -resize 256x256 "$OUTPUT_DIR/fritzing_256.png"

echo "Conversion complete! Files saved in $OUTPUT_DIR:"
ls -1 fritzing_64.png fritzing_128.png fritzing_256.png

exit 0
