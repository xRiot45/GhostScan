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

# Main Menu
function show_menu() {
    echo -e "   "
    echo -e "   ${GRN}1${RST}) Host Discovery              "
    echo -e "   ${GRN}2${RST}) Port & Service Discovery    "
    echo -e "   ${GRN}3${RST}) OS Detection                "
    echo -e "   ${GRN}4${RST}) Exit                        "
    echo -e "   "
}

# Submenu: Host Discovery
function show_menu_host_discovery() {
    echo -e "   "
    echo -e "   ${GRN}1${RST}) ARP Ping Scan               "
    echo -e "   ${GRN}2${RST}) UDP Ping Scan               "
    echo -e "   ${GRN}3${RST}) ICMP Echo Ping Scan         "
    echo -e "   ${GRN}4${RST}) ICMP Echo Ping Sweep        "
    echo -e "   ${GRN}5${RST}) ICMP Timestamp Ping Scan    "
    echo -e "   ${GRN}6${RST}) ICMP Address Mask Ping Scan "
    echo -e "   ${GRN}7${RST}) TCP SYN Ping Scan           "
    echo -e "   ${GRN}8${RST}) TCP ACK Ping Scan           "
    echo -e "   ${GRN}9${RST}) IP Protocol Ping Scan       "
    echo -e "   ${GRN}10${RST}) Run All Methods            "
    echo -e "   ${GRN}0${RST}) Back                        "
    echo -e "   "
}

# Submenu: Port Discovery
function show_menu_port_discovery() {
    echo -e "   "
    echo -e "   ${GRN}1${RST}) TCP Connect / Full-Open Scan         "
    echo -e "   ${GRN}2${RST}) Stealth Scan (Half-Open Scan)        "
    echo -e "   ${GRN}3${RST}) Inverse TCP Flag Scan (Submenu)      "
    echo -e "   ${GRN}4${RST}) TCP Maimon Scan                      "
    echo -e "   ${GRN}5${RST}) ACK Flag Probe Scan                  "
    echo -e "   ${GRN}6${RST}) IDLE / IPID Header Scan              "
    echo -e "   ${GRN}7${RST}) UDP Scan                             "
    echo -e "   ${GRN}8${RST}) SCTP INIT Scan                       "
    echo -e "   ${GRN}9${RST}) SCTP COOKIE ECHO Scan                "
    echo -e "   ${GRN}0${RST}) Back                                 "
    echo -e "   "
}

# Submenu: Inverse TCP Flag Scan
function show_menu_inverse_tcp_flag() {
    echo -e "   "
    echo -e "   ${GRN}1${RST}) Xmas Scan "
    echo -e "   ${GRN}2${RST}) FIN Scan  "
    echo -e "   ${GRN}3${RST}) NULL Scan "
    echo -e "   ${GRN}0${RST}) Back      "
    echo -e "   "
}

# Submenu: ACK Flag Probe Scan
function show_menu_ack_probe_scan() {
    echo -e "   "
    echo -e "   ${GRN}1${RST}) ACK Flag Probe Scan          "
    echo -e "   ${GRN}2${RST}) TTL-Based ACK Flag Probe     "
    echo -e "   ${GRN}3${RST}) Window-Based ACK Flag Probe  "
    echo -e "   ${GRN}0${RST}) Back                         "
    echo -e "   "
}

# Check root
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

while true; do
    show_menu
    read -p "Select Option: " opt

    case $opt in
    1) # Host Discovery
        show_menu_host_discovery
        read -p "Select Method: " method

        case $method in
        1) HOST_DISCOVERY_METHOD="arp-ping-scan" ;;
        2) HOST_DISCOVERY_METHOD="udp-ping-scan" ;;
        3) HOST_DISCOVERY_METHOD="icmp-echo-ping-scan" ;;
        4) HOST_DISCOVERY_METHOD="icmp-echo-ping-sweep" ;;
        5) HOST_DISCOVERY_METHOD="icmp-timestamp-ping-scan" ;;
        6) HOST_DISCOVERY_METHOD="icmp-address-mask-ping-scan" ;;
        7) HOST_DISCOVERY_METHOD="tcp-syn-ping-scan" ;;
        8) HOST_DISCOVERY_METHOD="tcp-ack-ping-scan" ;;
        9) HOST_DISCOVERY_METHOD="ip-protocol-ping-scan" ;;
        10)
            METHODS=("arp-ping-scan" "udp-ping-scan" "icmp-echo-ping-scan"
                "icmp-echo-ping-sweep" "icmp-timestamp-ping-scan"
                "icmp-address-mask-ping-scan" "tcp-syn-ping-scan"
                "tcp-ack-ping-scan" "ip-protocol-ping-scan")
            for HOST_DISCOVERY_METHOD in "${METHODS[@]}"; do
                echo -e "${YLW}[i] Running $HOST_DISCOVERY_METHOD...${RST}"
                bash src/modules/host_discovery.sh "$target" "$TARGET_RAW_DIR" "$HOST_DISCOVERY_METHOD"
            done
            continue
            ;;
        0)
            banner
            continue
            ;;
        *)
            echo -e "${RED}[!] Invalid option${RST}"
            continue
            ;;
        esac

        bash src/modules/host_discovery.sh "$target" "$TARGET_RAW_DIR" "$HOST_DISCOVERY_METHOD"
        ;;

    2) # Port Discovery
        show_menu_port_discovery
        read -p "Select Method: " method

        case $method in
        1) PORT_DISCOVERY_METHOD="tcp-connect-scan" ;;
        2) PORT_DISCOVERY_METHOD="stealth-scan" ;;
        3)
            while true; do
                show_menu_inverse_tcp_flag
                read -p "Select Inverse TCP Method: " inv
                case $inv in
                1)
                    PORT_DISCOVERY_METHOD="xmas-scan"
                    break
                    ;;
                2)
                    PORT_DISCOVERY_METHOD="fin-scan"
                    break
                    ;;
                3)
                    PORT_DISCOVERY_METHOD="null-scan"
                    break
                    ;;
                0)
                    PORT_DISCOVERY_METHOD=""
                    break
                    ;;
                *) echo -e "${RED}[!] Invalid option${RST}" ;;
                esac
            done
            [ -z "$PORT_DISCOVERY_METHOD" ] && continue
            ;;
        4) PORT_DISCOVERY_METHOD="tcp-maimon-scan" ;;
        5)
            while true; do
                show_menu_ack_probe_scan
                read -p "Select ACK Flag Probe Method: " ack
                case $ack in
                1)
                    PORT_DISCOVERY_METHOD="ack-flag-probe-scan"
                    break
                    ;;
                2)
                    PORT_DISCOVERY_METHOD="ttl-based-ack-flag-probe-scan"
                    break
                    ;;
                3)
                    PORT_DISCOVERY_METHOD="window-based-ack-flag-probe-scan"
                    break
                    ;;
                0)
                    PORT_DISCOVERY_METHOD=""
                    break
                    ;;
                *) echo -e "${RED}[!] Invalid option${RST}" ;;
                esac
            done
            [ -z "$PORT_DISCOVERY_METHOD" ] && continue
            ;;
        6)
            read -p "$(echo -e ${YLW}[?]${RST} Enter Zombie IP:) " zombie_ip
            PORT_DISCOVERY_METHOD="idle-scan:$zombie_ip"
            ;;

        7) PORT_DISCOVERY_METHOD="udp-scan" ;;
        8) PORT_DISCOVERY_METHOD="sctp-init-scan" ;;
        # 9) PORT_DISCOVERY_METHOD="sctp-cookie-echo-scan" ;;
        0)
            banner
            continue
            ;;
        *)
            echo -e "${RED}[!] Invalid option${RST}"
            continue
            ;;
        esac

        bash src/modules/port_discovery.sh "$target" "$TARGET_RAW_DIR" "$PORT_DISCOVERY_METHOD"
        ;;

    3)
        echo -e "${CYN}[i] OS Detection coming soon...${RST}"
        ;;
    4)
        echo -e "${MAG}[i] Exiting GhostScan...${RST}"
        exit 0
        ;;
    *) echo -e "${RED}[!] Invalid choice${RST}" ;;
    esac
done
