#!/bin/bash

VIDEO_DIR="${1:-.}"
THUMBNAIL_DIR="${2:-$VIDEO_DIR/thumbnails}"

mkdir -p "$THUMBNAIL_DIR"

for video in "$VIDEO_DIR"/*.{mp4,mkv,avi,mov}; do
    [ -e "$video" ] || continue

    filename=$(basename -- "$video")
    filename_no_ext="${filename%.*}"

    # generate thumbnail (at 4` seconds)
    ffmpeg -i "$video" -ss 00:00:04 -vframes 1 "$THUMBNAIL_DIR/$filename_no_ext.jpg" -y &>/dev/null

    echo "Thumbnail created: $THUMBNAIL_DIR/$filename_no_ext.jpg"
done

echo "Thumbnails generated in: $THUMBNAIL_DIR"
