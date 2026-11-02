
#!/usr/bin/env bash

echo "===== System Health Check ====="

# CPU
echo
echo "[CPU]"
uptime

# RAM
echo
echo "[RAM]"
free -h

# Disk
echo
echo "[DISK]"
df -h /

# GPU
echo
echo "[GPU]"

if command -v nvidia-smi >/dev/null 2>&1; then
    nvidia-smi \
        --query-gpu=name,driver_version,temperature.gpu,utilization.gpu,memory.used,memory.total \
        --format=csv
else
    echo "[!] NVIDIA GPU utility (nvidia-smi) is unavailable."
    echo "    NVIDIA GPU information cannot be retrieved through this tool."
fi


# Network
echo
echo "[NETWORK]"

# Local IP addresses
echo "IP address(es):"
ip -brief address show | awk '$1 != "lo" {print $1, $3}'

# Default gateway
echo
echo "Default gateway:"
ip route show default | awk '{print $3, "(" $5 ")" }'

# Internet connectivity
echo
if ping -c 1 -W 2 1.1.1.1 >/dev/null 2>&1; then
    echo "[✓] Internet connection is available."
else
    echo "[✗] No response from internet connectivity test."
fi


echo
echo "===== Health Check Complete ====="
