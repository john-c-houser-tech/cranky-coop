#!/bin/sh
# game.html is the page body (it is also what gets published as the claude.ai artifact).
# index.html wraps it in a full document for https://cranky-coop.localhost:8443.
cd "$(dirname "$0")"
# Refuse to build if the game script doesn't parse.
tmp=$(mktemp --suffix=.js)
sed -n '/^<script>$/,/^<\/script>$/p' game.html | sed '1d;$d' > "$tmp"
node --check "$tmp" || { rm -f "$tmp"; exit 1; }
rm -f "$tmp"
{ printf '<!doctype html>\n<html lang="en">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n</head>\n<body>\n'
  cat game.html
  printf '</body>\n</html>\n'; } > index.html
