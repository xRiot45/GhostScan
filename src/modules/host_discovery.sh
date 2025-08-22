#!/bin/bash

target=$1
dir=$2
method=$3

echo "[Host Discovery] Target: $target | Method: $method | Output dir: $dir"

source src/utils/progress_bar.sh

OUTPUT_DIR="$dir/host_discovery"
mkdir -p "$OUTPUT_DIR"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUTPUT_FILE="$OUTPUT_DIR/${method}_scan_$TIMESTAMP.txt"

echo -e "\n\e[32m[+]\e[0m Starting Host Discovery (\e[36m$method\e[0m) on \e[33m$target\e[0m ..."
echo -e "\e[32m[+]\e[0m Output will be saved to \e[35m$OUTPUT_FILE\e[0m"
echo ""

# Run scan
case $method in
arp-ping-scan) (nmap -sn -PR $target | tee "$OUTPUT_FILE") >/dev/null 2>&1 & ;;
udp-ping-scan) (nmap -sn -PU $target | tee "$OUTPUT_FILE") >/dev/null 2>&1 & ;;
icmp-echo-ping-scan) (nmap -sn -PE $target | tee "$OUTPUT_FILE") >/dev/null 2>&1 & ;;
icmp-echo-ping-sweep)
    SUBNET="${target}/24"
    (nmap -sn -PE $SUBNET | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
icmp-timestamp-ping-scan) (nmap -sn -PP $target | tee "$OUTPUT_FILE") >/dev/null 2>&1 & ;;
icmp-address-mask-ping-scan) (nmap -sn -PM $target | tee "$OUTPUT_FILE") >/dev/null 2>&1 & ;;
tcp-syn-ping-scan) (nmap -sn -PS $target | tee "$OUTPUT_FILE") >/dev/null 2>&1 & ;;
tcp-ack-ping-scan) (nmap -sn -PA $target | tee "$OUTPUT_FILE") >/dev/null 2>&1 & ;;
ip-protocol-ping-scan) (nmap -sn -PO $target | tee "$OUTPUT_FILE") >/dev/null 2>&1 & ;;
*)
    echo -e "\e[31m[!]\e[0m Unknown method: $method"
    exit 1
    ;;
esac

PID=$!
progress_bar
wait $PID

echo -e "\n\e[32m[+]\e[0m Scan complete! Results saved in \e[35m$OUTPUT_FILE\e[0m"
