#!/bin/bash
set -euo pipefail

subdir="${1:-}"
dir="${2:-}"

if [ -z "$subdir" ] || [ -z "$dir" ]; then
    echo "Usage: preview_tail.sh <subdir> <dir>"
    exit 1
fi

TARGET_DIR="$dir/$subdir"

if [ -d "$TARGET_DIR" ] && compgen -G "$TARGET_DIR/*" >/dev/null 2>&1; then
    ls -1t "$TARGET_DIR"/* 2>/dev/null | head -n 3 | while IFS= read -r f; do
        echo "==> $f"
        tail -n 20 "$f" || true
        echo
    done
else
    echo "No recent results in $TARGET_DIR"
fi
