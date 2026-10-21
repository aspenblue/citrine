#!/usr/bin/env bash
set -euo pipefail

URL="https://cinnamon-spices.linuxmint.com/files/applets/Cinnamenu@json.zip"
TYPE="applets"
NAME="Cinnamenu@json"

DEST="/usr/share/cinnamon/$TYPE/$NAME"
TMP="$(mktemp -d)"

trap 'rm -rf "$TMP"' EXIT

curl -fL --retry 3 "$URL" -o "$TMP/Cinnamenu@json.zip"

mkdir -p "$TMP/extracted"
unzip -q "$TMP/Cinnamenu@json.zip" -d "$TMP/extracted"

shopt -s dotglob
ITEMS=("$TMP/extracted"/*)

if [[ ${#ITEMS[@]} -eq 1 && -d "${ITEMS[0]}" ]]; then
    SOURCE="${ITEMS[0]}"
else
    SOURCE="$TMP/extracted"
fi

mkdir -p "$DEST"
cp -a "$SOURCE"/. "$DEST"/

echo "Installed Cinnamon Spice to $DEST"
