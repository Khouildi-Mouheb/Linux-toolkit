#!/usr/bin/env bash

show_help() {
    cat <<'EOF'
Usage: fwcheck [OPTION]

Audit the UFW firewall configuration.

Options:
  --help       Display this help message

Checks:
  - UFW status
  - Default firewall policies
  - Configured firewall rules
  - Potentially risky settings

This command does not modify firewall settings.
EOF
}

# Handle arguments
for arg in "$@"; do
    case "$arg" in
        --help)
            show_help
            exit 0
            ;;
        *)
            echo "Error: Unknown option '$arg'"
            echo "Use 'fwcheck --help' for usage."
            exit 1
            ;;
    esac
done

echo "===== Linux Toolkit: Firewall Audit ====="
echo

# Check whether UFW is installed
if ! command -v ufw >/dev/null 2>&1; then
    echo "[!] UFW is not installed."
    exit 1
fi

# Check whether UFW is active
status=$(sudo ufw status 2>&1)
if [[ $? -ne 0 ]]; then
    echo "[!] Unable to retrieve UFW status."
    echo "$status"
    exit 1
fi

echo "[1] Firewall Status"
echo "$status" | head -n 1
echo

if echo "$status" | grep -q "^Status: active$"; then
    echo "[✓] UFW is active."
else
    echo "[!] UFW is inactive."
fi

# Read detailed configuration
verbose_status=$(sudo ufw status verbose 2>&1)

echo
echo "[2] Default Policies"

if [[ "$verbose_status" == *"Default:"* ]]; then
    policies=$(echo "$verbose_status" | grep "^Default:")
    echo "$policies"

    if echo "$policies" | grep -q "deny (incoming)"; then
        echo "[✓] Incoming traffic is denied by default."
    else
        echo "[!] Incoming traffic is not denied by default."
    fi

    if echo "$policies" | grep -q "allow (outgoing)"; then
        echo "[i] Outgoing traffic is allowed by default."
    fi
else
    echo "[!] Could not read default policies."
fi

echo
echo "[3] Configured Rules"
sudo ufw status numbered

echo
echo "[4] Security Summary"

if echo "$status" | grep -q "^Status: active$"; then
    echo "[✓] Firewall is enabled."
else
    echo "[!] Firewall is disabled."
fi

if echo "$verbose_status" | grep -q "deny (incoming)"; then
    echo "[✓] Default incoming policy is restrictive."
else
    echo "[!] Review your default incoming policy."
fi

echo
echo "===== Audit Complete ====="
echo "Note: This audit checks UFW settings, not every aspect of network security."