#!/bin/bash

source src/utils/banner.sh

# Colors
RED="\e[31m"
GRN="\e[32m"
YLW="\e[33m"
BLU="\e[34m"
CYN="\e[36m"
MAG="\e[35m"
RST="\e[0m"

# Directories
RAW_DIR="src/results/raw"
PARSED_DIR="src/results/parsed"
mkdir -p "$RAW_DIR" "$PARSED_DIR"

# Menu box
function show_menu() {
    echo -e "${BLU}┌────────────────────────────┐${RST}"
    echo -e "${BLU}│ ${GRN}1${RST}) Host Discovery         ${BLU}│${RST}"
    echo -e "${BLU}│ ${GRN}2${RST}) Port & Service Scan    ${BLU}│${RST}"
    echo -e "${BLU}│ ${GRN}3${RST}) OS Detection           ${BLU}│${RST}"
    echo -e "${BLU}│ ${GRN}4${RST}) Exit                   ${BLU}│${RST}"
    echo -e "${BLU}└────────────────────────────┘${RST}"
}

# Submenu box for host discovery
function show_host_discovery() {
    echo -e "${CYN}┌──────────────────────────────┐${RST}"
    echo -e "${CYN}│ ${GRN}1${RST}) ARP Ping Scan               ${CYN}│${RST}"
    echo -e "${CYN}│ ${GRN}2${RST}) UDP Ping Scan               ${CYN}│${RST}"
    echo -e "${CYN}│ ${GRN}3${RST}) ICMP Echo Ping Scan         ${CYN}│${RST}"
    echo -e "${CYN}│ ${GRN}4${RST}) ICMP Echo Ping Sweep        ${CYN}│${RST}"
    echo -e "${CYN}│ ${GRN}5${RST}) ICMP Timestamp Ping Scan    ${CYN}│${RST}"
    echo -e "${CYN}│ ${GRN}5${RST}) Back                        ${CYN}│${RST}"
    echo -e "${CYN}└──────────────────────────────┘${RST}"
}

# Check root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}[!]${RST} Run as root!"
    echo -e "${BLU}[i]${RST} Example: sudo $0"
    exit 1
fi

# Start program
banner
read -p "$(echo -e ${YLW}[?]${RST} Enter target IP/Range:)" target

SAFE_TARGET=$(echo "$target" | sed 's/\//_/g')
TARGET_RAW_DIR="$RAW_DIR/$SAFE_TARGET"
mkdir -p "$TARGET_RAW_DIR"

while true; do
    show_menu
    read -p "Select Option: " opt

    case $opt in
    1)
        show_host_discovery
        read -p "Select Method: " method

        case $method in
        1) DISCOVERY_METHOD="arp-ping-scan" ;;
        2) DISCOVERY_METHOD="udp-ping-scan" ;;
        3) DISCOVERY_METHOD="icmp-echo-ping-scan" ;;
        4) DISCOVERY_METHOD="icmp-echo-ping-sweep" ;;
        5) DISCOVERY_METHOD="icmp-timestamp-ping-scan" ;;
        6)
            banner
            continue
            ;;
        *)
            echo -e "${RED}[!] Invalid option${RST}"
            continue
            ;;
        esac

        # Call the host discovery module
        bash src/modules/host_discovery.sh "$target" "$TARGET_RAW_DIR" "$DISCOVERY_METHOD"
        ;;
    2)
        echo -e "${CYN}[i] Port & Service Scan coming soon...${RST}"
        ;;
    3)
        echo -e "${CYN}[i] OS Detection coming soon...${RST}"
        ;;
    4)
        echo -e "${MAG}[i] Exiting GhostScan...${RST}"
        exit 0
        ;;
    *)
        echo -e "${RED}[!] Invalid choice${RST}"
        ;;
    esac
done
