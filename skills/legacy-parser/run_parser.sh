#!/bin/sh
set -eu

HW3_ROOT="/home/ubuntu/Desktop/765HW3"
INBOX="$HW3_ROOT/inbox"
PARSER="$HW3_ROOT/legacy_log_parser"

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <file-under-inbox>" >&2
    exit 2
fi

BASE_REAL="$(realpath -e "$INBOX")"
TARGET_REAL="$(realpath -e -- "$1")" || {
    echo "Rejected: file does not exist" >&2
    exit 3
}

case "$TARGET_REAL" in
    "$BASE_REAL"/*)
        ;;
    *)
        echo "Rejected: path is outside inbox/" >&2
        exit 4
        ;;
esac

if [ ! -f "$TARGET_REAL" ]; then
    echo "Rejected: target is not a regular file" >&2
    exit 5
fi

exec "$PARSER" "$TARGET_REAL"