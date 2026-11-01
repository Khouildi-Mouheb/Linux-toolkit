
#!/usr/bin/env bash

if [[ $# -ne 1 ]]; then
    echo "Usage: unapp <appName>"
    exit 1
fi

appName="$1"

SCRIPT_PATH="$(readlink -f -- "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
CONFIG_FILE="$PROJECT_ROOT/config/apps.conf"

if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "Error: application registry not found."
    exit 1
fi

if ! grep -qFx "$appName" "$CONFIG_FILE" &&
   ! grep -q "^${appName}=" "$CONFIG_FILE"; then
    echo "Error: '$appName' is not registered."
    exit 1
fi

TEMP_FILE="$(mktemp)" || exit 1

while IFS='=' read -r name path; do
    if [[ "$name" != "$appName" ]]; then
        printf '%s=%s\n' "$name" "$path" >> "$TEMP_FILE"
    fi
done < "$CONFIG_FILE"

if cat "$TEMP_FILE" > "$CONFIG_FILE"; then
    rm -f "$TEMP_FILE"
    echo "Application '$appName' unregistered successfully."
else
    rm -f "$TEMP_FILE"
    echo "Error: failed to update the application registry."
    exit 1
fi
