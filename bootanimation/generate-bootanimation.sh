#!/bin/bash

WIDTH="$1"
HEIGHT="$2"
HALF_RES="$3"
BOOTANIOUT="$ANDROID_PRODUCT_OUT/obj/BOOTANIMATION"

if [ "$HEIGHT" -lt "$WIDTH" ]; then
    IMAGEWIDTH="$HEIGHT"
else
    IMAGEWIDTH="$WIDTH"
fi

IMAGESCALEWIDTH="$IMAGEWIDTH"
IMAGESCALEHEIGHT=$(expr $IMAGESCALEWIDTH / 3)

if [ "$HALF_RES" = "true" ]; then
    IMAGEWIDTH=$(expr $IMAGEWIDTH / 2)
fi

IMAGEHEIGHT=$(expr $IMAGEWIDTH / 3)

RESOLUTION=""$IMAGEWIDTH"x"$IMAGEHEIGHT""

for part_cnt in 0 1 2 3 4
do
    mkdir -p $ANDROID_PRODUCT_OUT/obj/BOOTANIMATION/bootanimation/Part$part_cnt
done
tar xfp "vendor/invictrix/bootanimation/bootanimation.tar" -C "$BOOTANIOUT/bootanimation/"
mogrify -resize $RESOLUTION -colors 250 "$BOOTANIOUT/bootanimation/"*"/"*".jpg"

# Create desc.txt
echo "$IMAGESCALEWIDTH $IMAGESCALEHEIGHT" 24 > "$BOOTANIOUT/bootanimation/desc.txt"
cat "vendor/invictrix/bootanimation/desc.txt" >> "$BOOTANIOUT/bootanimation/desc.txt"

# Create bootanimation.zip
cd "$BOOTANIOUT/bootanimation"

zip -qr0 "$BOOTANIOUT/bootanimation.zip" .
