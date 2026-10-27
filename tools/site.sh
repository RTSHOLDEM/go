#!/bin/bash
# Usage: tools/site.sh <slug> <url> "<title>"
# Website link (taap.it-style): from Instagram/TikTok it opens the real browser, elsewhere a plain redirect.
set -e
cd "$(dirname "$0")/.."
slug=$1 url=$2 title=$3
[ -n "$slug" ] && [ -n "$url" ] && [ -n "$title" ] || { echo "usage: tools/site.sh slug url \"title\""; exit 1; }
mkdir -p "$slug"
esc=$(printf '%s' "$title" | sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/"/\&quot;/g' -e 's/[\/|]/\\&/g')
u=$(printf '%s' "$url" | sed -e 's/[\/|&]/\\&/g')
sed -e "s|__URL__|$u|g" -e "s|__TITLE__|$esc|g" tools/template-site.html > "$slug/index.html"
git add -A && git commit -qm "link $slug -> $url" && git push -q
echo "https://rtsholdem.github.io/go/$slug/"
