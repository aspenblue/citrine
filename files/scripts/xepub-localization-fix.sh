#!/usr/bin/env bash

set -euo pipefail

SOURCE="/usr/share/applications/"
TARGET="/usr/etc/xdg/applications/"
FILE="xepub.desktop"

[[ -f "${SOURCE}${FILE}" ]] || exit 0

install -D -m 0644 "${SOURCE}${FILE}" "${TARGET}${FILE}"

if grep -q '^Name\[ru\]=' "${TARGET}${FILE}"; then
    sed -i '/^\[Desktop Entry\]/,/^\[/{
        /^Name\[ru\]=/d
    }' "${TARGET}${FILE}"
fi

sed -i '/^\[Desktop Entry\]/,/^\[/{
    /^Name=/a Name[ru]=Электронные книги
}' "${TARGET}${FILE}"
