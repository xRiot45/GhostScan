#!/bin/bash
source src/utils/colors.sh

locate_module_host_discovery="src/modules/host_discovery.sh"
locate_module_port_discovery="src/modules/port_discovery.sh"
locate_module_os_discovery="src/modules/os_discovery.sh"
locate_module_evasion_techniques="src/modules/evasion_techniques.sh"

function handle_host_discovery() {
    local target="$1"
    local dir="$2"

    host_menu() {
        printf '%s\n' \
            "ARP Ping Scan" \
            "UDP Ping Scan" \
            "ICMP Echo Ping Scan" \
            "ICMP Echo Ping Sweep" \
            "ICMP Timestamp Ping Scan" \
            "ICMP Address Mask Ping Scan" \
            "TCP SYN Ping Scan" \
            "TCP ACK Ping Scan" \
            "IP Protocol Ping Scan" \
            "Run All Methods" \
            "Back"
    }

    local choice
    choice=$(
        host_menu | fzf \
            --ansi \
            --prompt="Host Discovery > " \
            --height=15 \
            --reverse \
            --border
    )

    case "${choice:-}" in
    "Back" | "") return ;;
    "Run All Methods")
        for m in \
            "arp-ping-scan" "udp-ping-scan" "icmp-echo-ping-scan" \
            "icmp-echo-ping-sweep" "icmp-timestamp-ping-scan" \
            "icmp-address-mask-ping-scan" "tcp-syn-ping-scan" \
            "tcp-ack-ping-scan" "ip-protocol-ping-scan"; do
            bash $locate_module_host_discovery "$target" "$dir" "$m"
        done
        ;;
    "ARP Ping Scan")
        bash $locate_module_host_discovery "$target" "$dir" "arp-ping-scan"
        ;;
    "UDP Ping Scan")
        bash $locate_module_host_discovery "$target" "$dir" "udp-ping-scan"
        ;;
    "ICMP Echo Ping Scan")
        bash $locate_module_host_discovery "$target" "$dir" "icmp-echo-ping-scan"
        ;;
    "ICMP Echo Ping Sweep")
        bash $locate_module_host_discovery "$target" "$dir" "icmp-echo-ping-sweep"
        ;;
    "ICMP Timestamp Ping Scan")
        bash $locate_module_host_discovery "$target" "$dir" "icmp-timestamp-ping-scan"
        ;;
    "ICMP Address Mask Ping Scan")
        bash $locate_module_host_discovery "$target" "$dir" "icmp-address-mask-ping-scan"
        ;;
    "TCP SYN Ping Scan")
        bash $locate_module_host_discovery "$target" "$dir" "tcp-syn-ping-scan"
        ;;
    "TCP ACK Ping Scan")
        bash $locate_module_host_discovery "$target" "$dir" "tcp-ack-ping-scan"
        ;;
    "IP Protocol Ping Scan")
        bash $locate_module_host_discovery "$target" "$dir" "ip-protocol-ping-scan"
        ;;
    esac
}

function handle_port_discovery() {
    local target="$1"
    local dir="$2"

    port_menu() {
        printf '%s\n' \
            "TCP Connect / Full-Open Scan" \
            "Stealth Scan (Half-Open Scan)" \
            "Xmas Scan" \
            "FIN Scan" \
            "NULL Scan" \
            "TCP Maimon Scan" \
            "ACK Flag Probe Scan" \
            "TTL-Based ACK Flag Probe Scan" \
            "Window-Based ACK Flag Probe Scan" \
            "IDLE / IPID Header Scan" \
            "UDP Scan" \
            "SCTP INIT Scan" \
            "SCTP COOKIE ECHO Scan" \
            "Service Version Detection" \
            "Back"
    }

    local choice
    choice=$(
        port_menu | fzf \
            --ansi \
            --prompt="Port Discovery > " \
            --height=17 \
            --reverse \
            --border
    )

    case "${choice:-}" in
    "Back" | "") return ;;
    "TCP Connect / Full-Open Scan")
        bash $locate_module_port_discovery "$target" "$dir" "tcp-connect-scan"
        ;;
    "Stealth Scan (Half-Open Scan)")
        bash $locate_module_port_discovery "$target" "$dir" "stealth-scan"
        ;;
    "Xmas Scan")
        bash $locate_module_port_discovery "$target" "$dir" "xmas-scan"
        ;;
    "FIN Scan")
        bash $locate_module_port_discovery "$target" "$dir" "fin-scan"
        ;;
    "NULL Scan")
        bash $locate_module_port_discovery "$target" "$dir" "null-scan"
        ;;
    "TCP Maimon Scan")
        bash $locate_module_port_discovery "$target" "$dir" "tcp-maimon-scan"
        ;;
    "ACK Flag Probe Scan")
        bash $locate_module_port_discovery "$target" "$dir" "ack-flag-probe-scan"
        ;;
    "TTL-Based ACK Flag Probe Scan")
        bash $locate_module_port_discovery "$target" "$dir" "ttl-based-ack-flag-probe-scan"
        ;;
    "Window-Based ACK Flag Probe Scan")
        bash $locate_module_port_discovery "$target" "$dir" "window-based-ack-flag-probe-scan"
        ;;
    "IDLE / IPID Header Scan")
        read -rp "$(echo -e ${YLW}[?]${RST} Enter Zombie IP:) " zombie_ip
        bash $locate_module_port_discovery "$target" "$dir" "idle-scan:$zombie_ip"
        ;;
    "UDP Scan")
        bash $locate_module_port_discovery "$target" "$dir" "udp-scan"
        ;;
    "SCTP INIT Scan")
        bash $locate_module_port_discovery "$target" "$dir" "sctp-init-scan"
        ;;
    "SCTP COOKIE ECHO Scan")
        bash $locate_module_port_discovery "$target" "$dir" "sctp-cookie-echo-scan"
        ;;
    "Service Version Detection")
        bash $locate_module_port_discovery "$target" "$dir" "service-version-detection"
        ;;
    esac
}

function handle_os_discovery() {
    local target="$1"
    local dir="$2"

    os_menu() {
        printf '%s\n' \
            "Default OS Detection" \
            "Script Engine OS Detection" \
            "IPv6 OS Detection" \
            "Back"
    }

    local choice
    choice=$(
        os_menu | fzf \
            --ansi \
            --prompt="OS Discovery > " \
            --height=10 \
            --reverse \
            --border
    )

    case "${choice:-}" in
    "Back" | "") return ;;
    "Default OS Detection")
        bash $locate_module_os_discovery "$target" "$dir" "default-os-detection"
        ;;
    "Script Engine OS Detection")
        bash $locate_module_os_discovery "$target" "$dir" "script-engine-os-detection"
        ;;
    "IPv6 OS Detection")
        bash $locate_module_os_discovery "$target" "$dir" "ipv6-os-detection"
        ;;
    esac
}

function handle_evasion_techniques() {
    local target="$1"
    local dir="$2"

    evasion_menu() {
        printf '%s\n' \
            "SYN/FIN Scanning Using IP Fragments" \
            "Source Port Manipulation" \
            "IP Address Decoy Scan" \
            "IP Address Spoofing Scan" \
            "Creating Custom Packets Scan" \
            "Randomizing Host Order Scan" \
            "Sending Bad Checksum Packets Scan" \
            "Proxy Servers Scan" \
            "Anonymizers Scan" \
            "Back"
    }

    local choice
    choice=$(
        evasion_menu | fzf \
            --ansi \
            --prompt="Evasion Techniques > " \
            --height=15 \
            --reverse \
            --border
    )

    case "${choice:-}" in
    "Back" | "") return ;;
    "SYN/FIN Scanning Using IP Fragments")
        bash $locate_module_evasion_techniques "$target" "$dir" "ip-fragmentation-scan"
        ;;
    "Source Port Manipulation")
        read -rp "$(echo -e ${YLW}[?]${RST} Enter Port for Manipulation:) " port_manipulation
        bash $locate_module_evasion_techniques "$target" "$dir" "source-port-manipulation"
        ;;
    "IP Address Decoy Scan")
        bash $locate_module_evasion_techniques "$target" "$dir" "ip-address-decoy-scan"
        ;;
    "IP Address Spoofing Scan")
        bash $locate_module_evasion_techniques "$target" "$dir" "ip-address-spoofing-scan"
        ;;
    "Creating Custom Packets Scan")
        bash $locate_module_evasion_techniques "$target" "$dir" "custom-packets-scan"
        ;;
    "Randomizing Host Order Scan")
        bash $locate_module_evasion_techniques "$target" "$dir" "randomizing-host-order-scan"
        ;;
    "Sending Bad Checksum Packets Scan")
        bash $locate_module_evasion_techniques "$target" "$dir" "bad-checksum-packets-scan"
        ;;
    "Proxy Servers Scan")
        bash $locate_module_evasion_techniques "$target" "$dir" "proxy-servers-scan"
        ;;
    "Anonymizers Scan")
        bash $locate_module_evasion_techniques "$target" "$dir" "anonymizers-scan"
        ;;
    esac
}
