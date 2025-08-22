#!/bin/bash

set -euo pipefail

# Dependencies check
need_cmd() { command -v "$1" >/dev/null 2>&1 || {
    echo "Missing dependency: $1"
    exit 1
}; }
need_cmd nmap
need_cmd fzf

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
read -rp "$(echo -e ${YLW}[?]${RST} Enter target IP/Range:) " target

SAFE_TARGET=$(echo "$target" | sed 's/\//_/g')
TARGET_RAW_DIR="$RAW_DIR/$SAFE_TARGET"
mkdir -p "$TARGET_RAW_DIR"

main_menu() {
    printf '%s\n' \
        "Host Discovery" \
        "Port & Service Discovery" \
        "OS Detection" \
        "IDS/Firewall Evasion Techniques" \
        "Exit"
}

# Main loop with fzf
while true; do
    choice=$(main_menu | fzf \
        --ansi \
        --prompt="GhostScan > " \
        --height=15 \
        --reverse \
        --border \
        --margin=1,2 \
        --color=fg+:yellow,header:blue,info:green,pointer:cyan,marker:red)

    case "${choice:-}" in
    "Host Discovery") handle_host_discovery "$target" "$TARGET_RAW_DIR" ;;
    "Port & Service Discovery") handle_port_discovery "$target" "$TARGET_RAW_DIR" ;;
    "OS Detection") handle_os_discovery "$target" "$TARGET_RAW_DIR" ;;
    "IDS/Firewall Evasion Techniques") handle_evasion_techniques "$target" "$TARGET_RAW_DIR" ;;
    "Exit" | "")
        echo -e "${MAG}[i] Exiting GhostScan...${RST}"
        exit 0
        ;;
    esac
done
