#!/usr/bin/env bash

echo "===== Regular User Accounts ====="
echo

awk -F: '
    $3 >= 1000 && $7 !~ /nologin|false/ {
        printf "Username: %-20s UID: %-6s Home: %-25s Shell: %s\n", $1, $3, $6, $7
        found = 1
    }
    END {
        if (!found) {
            print "No regular user accounts found."
        }
    }
' /etc/passwd

echo
echo "===== Check Complete ====="