#!/usr/bin/env bash
set -euo pipefail

# URL архива Spice
URL="https://cinnamon-spices.linuxmint.com/files/applets/Cinnamenu@json.zip"

# Тип Spice: applets, extensions, desklets или themes
TYPE="applets"

# Имя папки Spice
NAME="Cinnamenu@json"

DEST="/usr/share/cinnamon/$TYPE/$NAME"
TMP="$(mktemp -d)"

trap 'rm -rf "$TMP"' EXIT

# Скачать архив
curl -fL --retry 3 "$URL" -o "$TMP/Cinnamenu@json.zip"

# Распаковать архив
mkdir -p "$TMP/extracted"
unzip -q "$TMP/Cinnamenu@json.zip" -d "$TMP/extracted"

# Если архив содержит единственную корневую папку — использовать её содержимое
shopt -s dotglob
ITEMS=("$TMP/extracted"/*)

if [[ ${#ITEMS[@]} -eq 1 && -d "${ITEMS[0]}" ]]; then
    SOURCE="${ITEMS[0]}"
else
    SOURCE="$TMP/extracted"
fi

# Установить Spice
mkdir -p "$DEST"
cp -a "$SOURCE"/. "$DEST"/

echo "Installed Cinnamon Spice to $DEST"
