

#!/usr/bin/env bash

show_all=true
show_cpu=false
show_memory=false

while getopts "cmh" opt; do
    case "$opt" in
        c)
            show_all=false
            show_cpu=true
            ;;
        m)
            show_all=false
            show_memory=true
            ;;
        h)
            echo "Usage: sysinfo [-c] [-m] [-h]"
            echo
            echo "Options:"
            echo "  -c    Show CPU information"
            echo "  -m    Show memory information"
            echo "  -h    Show this help message"
            exit 0
            ;;
        \?)
            echo "Invalid option. Use -h for help."
            exit 1
            ;;
    esac
done

show_system() {
    echo "===== System Information ====="
    echo "Hostname:     $(hostname)"
    echo "Distribution: $(. /etc/os-release && echo "$PRETTY_NAME")"
    echo "Kernel:       $(uname -r)"
    echo "Architecture: $(uname -m)"
    echo "Uptime:       $(uptime -p)"
}

show_cpu_info() {
    echo "===== CPU Information ====="
    awk -F ': ' '/model name/ {print "CPU:          " $2; exit}' /proc/cpuinfo
    echo "Logical CPUs: $(nproc)"
}

show_memory_info() {
    echo "===== Memory Information ====="
    free -h | awk 'NR == 1 || NR == 2'
}

if [[ "$show_all" == true ]]; then
    show_system
    echo
    show_cpu_info
    echo
    show_memory_info
else
    if [[ "$show_cpu" == true ]]; then
        show_cpu_info
        echo
    fi

    if [[ "$show_memory" == true ]]; then
        show_memory_info
        echo
    fi
fi