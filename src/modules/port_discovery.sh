#!/bin/bash

TARGET=$1
TARGET_DIR=$2
METHOD=$3

source src/utils/progress_bar.sh

OUTPUT_DIR="$TARGET_DIR/port_discovery"
mkdir -p "$OUTPUT_DIR"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUTPUT_FILE="$OUTPUT_DIR/${METHOD}_scan_$TIMESTAMP.txt"

echo -e "\n\e[32m[+]\e[0m Starting Port & Service Discovery (\e[36m$METHOD\e[0m) on \e[33m$TARGET\e[0m ..."
echo -e "\e[32m[+]\e[0m Output will be saved to \e[35m$OUTPUT_FILE\e[0m"
echo ""

case $METHOD in
tcp-connect-scan)
    (nmap -sT -v $TARGET | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
stealth-scan)
    (nmap -sS -v $TARGET | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
xmas-scan)
    (nmap -sX -v $TARGET | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
fin-scan)
    (nmap -sF -v $TARGET | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
null-scan)
    (nmap -sN -v $TARGET | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
tcp-maimon-scan)
    (nmap -sM -v $TARGET | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
ack-flag-probe-scan)
    (nmap -sA -v $TARGET | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
ttl-based-ack-flag-probe-scan)
    (nmap -sA --ttl 100 -v $TARGET | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
window-based-ack-flag-probe-scan)
    (nmap -sA -sW -v $TARGET | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
idle-scan:*)
    zombie_ip=$(echo "$METHOD" | cut -d':' -f2)
    (nmap -sI $zombie_ip $TARGET | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
udp-scan)
    (nmap -sU -v $TARGET | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    ;;
    # sctp-init-scan)
    #     (nmap -sY -v $TARGET | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    #     ;;
    # sctp-cookie-echo-scan)
    # (nmap -sZ -v $TARGET | tee "$OUTPUT_FILE") >/dev/null 2>&1 &
    # ;;
*)
    echo -e "\e[31m[-]\e[0m Invalid method: $METHOD"
    exit 1
    ;;
esac

PID=$!
progress_bar
wait $PID

echo -e "\n\e[32m[+]\e[0m Scan complete! Results saved in \e[35m$OUTPUT_FILE\e[0m"
