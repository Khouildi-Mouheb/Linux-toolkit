
#!/usr/bin/env bash

if [[ $# -ne 1 ]]; then
    echo "Usage: portcheck <port>"
    exit 1
fi

port="$1"

if [[ ! "$port" =~ ^[0-9]+$ ]] || (( port < 1 || port > 65535 )); then
    echo "Error: Port must be a number between 1 and 65535."
    exit 1
fi

if timeout 2 bash -c "echo > /dev/tcp/127.0.0.1/$port" 2>/dev/null; then
    echo "[✓] Port $port is accepting TCP connections on localhost."
else
    echo "[✗] Port $port is not accepting TCP connections on localhost."
fi
