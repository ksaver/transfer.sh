#!/bin/bash
#
#  transfer.sh
#  ~~~~~~~~~~~
#  Share files online to https://transfer.sh
#  from command line.
#  Requires curl in order to work and xclip optionally

function upload_n_clip() {
    SHARE_URL=$(curl -s --upload-file "$1" --url "https://transfer.sh/$1")
    echo -n "$SHARE_URL" | xclip -selection clipboard
    echo "[*] URL to share: $SHARE_URL"
    echo "[*] URL copied to clipboard."
}

function upload_only() {
    SHARE_URL=$(curl --upload-file "$1" --url "https://transfer.sh/$1")
    echo "[*] URL to share: $SHARE_URL"
}

function main() {
    if [ -z $1 ]; then
        echo "basename: $(Usage $0) <filename>"
        echo ""
        exit 1
    else
        FILE="$1"
    fi
    
    # curl required
    type curl &>/dev/null \
        || (echo "Please install curl before continue."; exit 1)
    
    # if xclip is not installed, upload file only
    # upload and copy url to clipboard otherwise
    echo "[*] Uploading \"$FILE\".."
    type xclip &>/dev/null
    if [ $? -eq 0 ]; then
        upload_n_clip $FILE
    else
        upload_only $FILE
    fi
}

main $1
