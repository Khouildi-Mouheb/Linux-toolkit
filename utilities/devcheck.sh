#!/usr/bin/env bash

if [[ $# -ne 1 ]]; then
    echo "Usage: devcheck <tool>"
    exit 1
fi

tool="$1"

if command -v "$tool" >/dev/null 2>&1; then
    echo "[✓] '$tool' is available."
    echo "Path: $(command -v "$tool")"

    version=$("$tool" --version 2>&1 | head -n 1)

    if [[ -n "$version" ]]; then
        echo "Version: $version"
    else
        echo "Version: unavailable"
    fi
else
    echo "[✗] '$tool' is not available in PATH."
    exit 1
fi