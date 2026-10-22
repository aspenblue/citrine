#!/usr/bin/env bash

set -euo pipefail

SOURCE="/usr/share/applications/"
TARGET="/usr/etc/xdg/applications/"
FILE="xviewer.desktop"

[[ -f "${SOURCE}${FILE}" ]] || exit 0

install -D -m 0644 "${SOURCE}${FILE}" "${TARGET}${FILE}"

sed -i '/^\[Desktop Entry\]/,/^\[/{
    s/^Name\[ru\]=Просмотрщик изображений$/Name[ru]=Просмотр изображений/
}' "${TARGET}${FILE}"
