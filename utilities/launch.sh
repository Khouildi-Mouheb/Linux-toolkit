
#!/usr/bin/env bash

if [[ $# -lt 1 ]]; then
    echo "Usage: launch.sh <appName> [arguments...]"
    exit 1
fi

appName="$1"
shift

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
CONFIG_FILE="$PROJECT_ROOT/config/apps.conf"

if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "Error: application registry not found."
    exit 1
fi

appPath=""


while IFS='=' read -r name path; do
    [[ "$name" == "$appName" ]] && {
        appPath="$path"
        break
    }
done < "$CONFIG_FILE"


if [[ -z "$appPath" ]]; then
    echo "Error: '$appName' is not registered in apps.conf."
    exit 1
fi

if [[ ! -x "$appPath" ]]; then
    echo "Error: executable '$appPath' does not exist or is not executable."
    exit 1
fi

echo "Launching '$appName'..."
"$appPath" "$@" &
