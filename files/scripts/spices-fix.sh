#!/usr/bin/env bash
set -euo pipefail

FILE="/usr/share/cinnamon/cinnamon-settings/bin/Spices.py"

if [[ ! -f "$FILE" ]]; then
    echo "Cinnamon Spices.py not found; skipping patch."
    exit 0
fi

OLD="totalSize = int(response.headers.get('content-length'))" 
NEW="totalSize = int(response.headers.get('content-length') or -1)"

if grep -Fq "$NEW" "$FILE"; then
    echo "Cinnamon Spices.py is already patched."
    exit 0
fi

if ! grep -Fq "$OLD" "$FILE"; then
    echo "ERROR: Expected source line not found in $FILE" >&2
    exit 1
fi

sed -i "s|$OLD|$NEW|" "$FILE"

if ! grep -Fq "$NEW" "$FILE"; then
    echo "ERROR: Patch verification failed." >&2
    exit 1
fi

echo "Cinnamon Spices.py patched successfully."
