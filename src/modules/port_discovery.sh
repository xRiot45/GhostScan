#!/bin/bash

set -euo pipefail

target=$1
dir=$2
method=$3

source src/utils/progress_bar.sh

OUTPUT_DIR="$dir/port_discovery"
mkdir -p "$OUTPUT_DIR"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUTPUT_FILE="$OUTPUT_DIR/${method}_scan_$TIMESTAMP.txt"

echo -e "\n\e[32m[+]\e[0m Starting (\e[36m$method\e[0m) on \e[33m$target\e[0m ..."
echo -e "\e[32m[+]\e[0m Output will be saved to \e[35m$OUTPUT_FILE\e[0m"
echo ""

case $method in
tcp-connect-scan)
    (nmap -sT -v "$target" | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
stealth-scan)
    (nmap -sS -v "$target" | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
xmas-scan)
    (nmap -sX -v "$target" | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
fin-scan)
    (nmap -sF -v "$target" | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
null-scan)
    (nmap -sN -v "$target" | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
tcp-maimon-scan)
    (nmap -sM -v "$target" | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
ack-flag-probe-scan)
    (nmap -sA -v "$target" | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
ttl-based-ack-flag-probe-scan)
    (nmap -sA --ttl 100 -v "$target" | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
window-based-ack-flag-probe-scan)
    (nmap -sA -sW -v "$target" | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
idle-scan:*)
    zombie_ip=$(echo "$method" | cut -d':' -f2)
    (nmap -sI "$zombie_ip" "$target" | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
udp-scan)
    (nmap -sU -v "$target" | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
sctp-init-scan)
    (nmap -sY -v "$target" | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
sctp-cookie-echo-scan)
    (nmap -sZ -v "$target" | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
service-version-detection)
    (nmap -sV -v "$target" | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
*)
    echo -e "\e[31m[-]\e[0m Invalid method: $method"
    exit 1
    ;;
esac

PID=$!
progress_bar
wait $PID

echo -e "\n\e[32m[+]\e[0m Scan complete! Results saved in \e[35m$OUTPUT_FILE\e[0m"
