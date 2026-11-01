
#!/usr/bin/env bash

# Locate the project directory, even when using a symbolic link
SCRIPT_PATH="$(readlink -f -- "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
CONFIG_FILE="$PROJECT_ROOT/config/apps.conf"

# Check whether the configuration file exists
if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "No application registry found."
    exit 1
fi

# Check whether the registry is empty
if [[ ! -s "$CONFIG_FILE" ]]; then
    echo "No applications registered."
    exit 0
fi

# Display registered applications
echo "Registered applications:"
while IFS='=' read -r name path; do
    [[ -z "$name" ]] && continue
    printf '%s -> %s\n' "$name" "$path"
done < "$CONFIG_FILE"
