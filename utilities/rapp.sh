
#!/usr/bin/env bash

if [[ $# -ne 2 ]]; then
    echo "Usage: rapp.sh <appName> <path>"
    exit 1
fi

appName="$1"
appPath="$2"

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
CONFIG_FILE="$PROJECT_ROOT/config/apps.conf"

mkdir -p "$(dirname "$CONFIG_FILE")"
touch "$CONFIG_FILE"

if [[ ! -x "$appPath" ]]; then
    echo "Error: '$appPath' is not an executable path."
    exit 1
fi

if grep -q "^${appName}=" "$CONFIG_FILE"; then
    echo "Error: '$appName' is already registered."
    exit 1
fi

printf '%s=%s\n' "$appName" "$appPath" >> "$CONFIG_FILE"

echo "Application '$appName' registered successfully."
