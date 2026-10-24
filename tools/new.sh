#!/bin/bash
# Usage: tools/new.sh <slug> <youtube video id> "<title>"
# Creates <slug>/index.html, publishes it, prints the link for the Instagram sticker.
set -e
cd "$(dirname "$0")/.."
slug=$1 id=$2 title=$3
[ -n "$slug" ] && [ -n "$id" ] && [ -n "$title" ] || { echo "usage: tools/new.sh slug videoId \"title\""; exit 1; }
mkdir -p "$slug"
esc=$(printf '%s' "$title" | sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/"/\&quot;/g' -e 's/[\/|]/\\&/g')
sed -e "s|__ID__|$id|g" -e "s|__TITLE__|$esc|g" tools/template.html > "$slug/index.html"
git add -A && git commit -qm "link $slug -> $id" && git push -q
echo "https://rtsholdem.github.io/go/$slug/"
