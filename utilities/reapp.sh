
#!/usr/bin/env bash

if [[ $# -ne 2 ]]; then
    echo "Usage: reapp <appName> <newPath>"
    exit 1
fi

appName="$1"
newPath="$2"

SCRIPT_PATH="$(readlink -f -- "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
CONFIG_FILE="$PROJECT_ROOT/config/apps.conf"

if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "Error: application registry not found."
    exit 1
fi

if [[ ! -x "$newPath" || -d "$newPath" ]]; then
    echo "Error: '$newPath' is not an executable file."
    exit 1
fi

if ! grep -q "^${appName}=" "$CONFIG_FILE"; then
    echo "Error: '$appName' is not registered."
    exit 1
fi

TEMP_FILE="$(mktemp)" || exit 1

while IFS='=' read -r name path; do
    if [[ "$name" == "$appName" ]]; then
        printf '%s=%s\n' "$name" "$newPath" >> "$TEMP_FILE"
    else
        printf '%s=%s\n' "$name" "$path" >> "$TEMP_FILE"
    fi
done < "$CONFIG_FILE"
apps
if cat "$TEMP_FILE" > "$CONFIG_FILE"; then
    rm -f "$TEMP_FILE"
    echo "Application '$appName' updated successfully."
else
    rm -f "$TEMP_FILE"
    echo "Error: failed to update the registry."
    exit 1
fi
