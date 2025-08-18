#!/bin/bash

TARGET=$1
TARGET_DIR=$2
METHOD=$3

source src/utils/progress_bar.sh

mkdir -p "$TARGET_DIR"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUTPUT_FILE="$TARGET_DIR/${METHOD}_scan_$TIMESTAMP.txt"

echo -e "\n\e[32m[+]\e[0m Starting Host Discovery (\e[36m$METHOD\e[0m) on \e[33m$TARGET\e[0m ..."
echo -e "\e[32m[+]\e[0m Output will be saved to \e[35m$OUTPUT_FILE\e[0m"
echo ""

# Run scan in background
case $METHOD in
arp-ping-scan)
    (nmap -sn -PR $TARGET | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
udp-ping-scan)
    (nmap -sn -PU $TARGET | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
icmp-echo-ping-scan)
    (nmap -sn -PE $TARGET | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
icmp-echo-ping-sweep)
    SUBNET="${TARGET}/24"
    (nmap -sn -PE $SUBNET | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
icmp-timestamp-ping-scan)
    (nmap -sn -PP $TARGET | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
*)
    echo -e "\e[31m[!]\e[0m Unknown method: $METHOD"
    exit 1
    ;;
esac

PID=$!
progress_bar
wait $PID

echo -e "\n\e[32m[+]\e[0m Scan complete! Results saved in \e[35m$OUTPUT_FILE\e[0m"
