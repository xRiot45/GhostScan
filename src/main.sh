#!/bin/bash

source src/utils/banner.sh
source src/utils/colors.sh
source src/utils/menus.sh
source src/helpers.sh

RAW_DIR="src/results/raw"
PARSED_DIR="src/results/parsed"
mkdir -p "$RAW_DIR" "$PARSED_DIR"

# Cek root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}[!]${RST} Run as root!"
    echo -e "${BLU}[i]${RST} Example: sudo $0"
    exit 1
fi

# Start
banner
read -p "$(echo -e ${YLW}[?]${RST} Enter target IP/Range:) " target

SAFE_TARGET=$(echo "$target" | sed 's/\//_/g')
TARGET_RAW_DIR="$RAW_DIR/$SAFE_TARGET"
mkdir -p "$TARGET_RAW_DIR"

# Main loop
while true; do
    show_menu
    read -p "Select Option: " opt

    case $opt in
    1) handle_host_discovery "$target" "$TARGET_RAW_DIR" ;;
    2) handle_port_discovery "$target" "$TARGET_RAW_DIR" ;;
    3) handle_os_discovery "$target" "$TARGET_RAW_DIR" ;;
    4) handle_evasion "$target" "$TARGET_RAW_DIR" ;;
    5)
        echo -e "${MAG}[i] Exiting GhostScan...${RST}"
        exit 0
        ;;
    *) echo -e "${RED}[!] Invalid choice${RST}" ;;
    esac
done
