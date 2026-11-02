
#!/usr/bin/env bash

echo "===== Network Security Audit ====="

echo
echo "[1] Network Interfaces and IP Addresses"
ip -brief address

echo
echo "[2] Default Gateway"
ip route show default


echo
echo "[3] Listening TCP Ports"

if command -v ss >/dev/null 2>&1; then
    ports=$(ss -lnt)
    echo "$ports"

    echo
    echo "[Security Check] Services listening on all interfaces"

    if echo "$ports" | awk 'NR > 1 && ($4 ~ /^0\.0\.0\.0:/ || $4 ~ /^\[::\]:/) {print; found=1} END {if (!found) exit 1}'; then
        echo "[!] Warning: These services may accept connections through network interfaces:"
        echo "$ports" | awk 'NR > 1 && ($4 ~ /^0\.0\.0\.0:/ || $4 ~ /^\[::\]:/)'
    else
        echo "[✓] No TCP listeners bound to 0.0.0.0 or [::] were detected."
    fi
else
    echo "[!] The 'ss' command is unavailable."
fi


echo
echo "===== Audit Complete ====="
