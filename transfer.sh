#!/bin/bash
#
#  transfer.sh
#  ~~~~~~~~~~~
#  Upload files to https://transfer.sh, for sharing online.

if [ -z "$1" ]; then
    # shellcheck disable=SC2086
    echo "Uso: $(basename $0) <filename>"
    exit 1
else
    FILE="$1"
    SHARE_URL=$(curl -s --upload-file "$FILE" "https://transfer.sh/${FILE}")
    echo -n "$SHARE_URL" | xclip -selection clipboard
    echo "[*] URL to share: $SHARE_URL"
    echo "(Copied to clipboard.)"
fi
