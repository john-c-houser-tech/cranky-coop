#!/bin/sh
# game.html is the page body (it is also what gets published as the claude.ai artifact).
# index.html wraps it in a full document for https://cranky-coop.localhost:8443.
#
# Usage: ./build.sh [source]
# The source defaults to game.html; the pre-commit hook passes the staged copy.
# Refuses to build when the game script doesn't parse, or can't be found:
# nouriloop-ops' games deploy relies on that to keep a broken game off the site.
set -eu
cd "$(dirname "$0")"
src=${1:-game.html}

[ -s "$src" ] || { echo "build.sh: $src is missing or empty" >&2; exit 1; }

# The game script sits between a line that is exactly <script> and one that is
# exactly </script>. Anything else would leave nothing to check.
start=$(grep -n -x '<script>' "$src" | head -n 1 | cut -d: -f1)
[ -n "$start" ] || { echo "build.sh: no line in $src is exactly <script>" >&2; exit 1; }
tail -n +"$start" "$src" | grep -q -x '</script>' \
  || { echo "build.sh: the <script> at line $start of $src is never closed by a line that is exactly </script>" >&2; exit 1; }

tmp=$(mktemp --suffix=.js)
trap 'rm -f "$tmp"' EXIT
sed -n '/^<script>$/,/^<\/script>$/p' "$src" | sed '1d;$d' > "$tmp"
grep -q '[^[:space:]]' "$tmp" || { echo "build.sh: the <script> block in $src is empty" >&2; exit 1; }

if ! node --check "$tmp"; then
  echo "build.sh: the script doesn't parse; add $start to the line number above to find it in $src" >&2
  exit 1
fi

{ printf '<!doctype html>\n<html lang="en">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n</head>\n<body>\n'
  cat "$src"
  printf '</body>\n</html>\n'; } > index.html
