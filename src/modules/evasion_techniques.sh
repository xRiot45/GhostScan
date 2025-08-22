#!/bin/bash

target=$1
dir=$2
method=$3

source src/utils/progress_bar.sh

OUTPUT_DIR="$dir/evasion_techniques"
mkdir -p "$OUTPUT_DIR"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUTPUT_FILE="$OUTPUT_DIR/${method}_scan_$TIMESTAMP.txt"

echo -e "\n\e[32m[+]\e[0m Starting (\e[36m$method\e[0m) on \e[33m$target\e[0m ..."
echo -e "\e[32m[+]\e[0m Output will be saved to \e[35m$OUTPUT_FILE\e[0m"
echo ""

case $method in
ip-fragmentation-scan)
    (nmap -sS -T4 -A -f -v "$target" | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
source-port-manipulation)
    port_manipulation=$(echo "$method" | cut -d':' -f2)
    (nmap -g "$port_manipulation" -v "$target" | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
ip-address-decoy)
    (nmap -D RND:10 -v "$target" | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
mac-address-spoofing)
    (nmap -sT -Pn --spoof-mac 0 -v "$target" | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
*)
    echo -e "\e[31m[!]\e[0m Unknown method: $method"
    exit 1
    ;;
esac

PID=$!
progress_bar
wait $PID

echo -e "\n\e[32m[+]\e[0m Scan complete! Results saved in \e[35m$OUTPUT_FILE\e[0m"
