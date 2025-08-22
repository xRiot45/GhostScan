#!/bin/bash

set -euo pipefail

target=$1
dir=$2
method=$3

echo "[OS Discovery] Target: $target | Method: $method | Output dir: $dir"

source src/utils/progress_bar.sh

OUTPUT_DIR="$dir/os_discovery"
mkdir -p "$OUTPUT_DIR"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUTPUT_FILE="$OUTPUT_DIR/${method}_scan_$TIMESTAMP.txt"

echo -e "\n\e[32m[+]\e[0m Starting OS Discovery (\e[36m$method\e[0m) on \e[33m$target\e[0m ..."
echo -e "\e[32m[+]\e[0m Output will be saved to \e[35m$OUTPUT_FILE\e[0m"
echo ""

case $method in
default-os-detection)
    (nmap -O -v "$target" | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
script-engine-os-detection)
    (nmap --script smb-os-discovery.nse -v "$target" | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
ipv6-os-detection)
    (nmap -6 -O -v "$target" | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
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
