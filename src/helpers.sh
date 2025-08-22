# Eksekusi modul
function run_module() {
    local module=$1
    local target=$2
    local dir=$3
    local method=$4

    echo -e "${YLW}[i] Running $method...${RST}"
    bash "src/modules/$module.sh" "$target" "$dir" "$method"
}

# Handler Host Discovery
function handle_host_discovery() {
    local target=$1
    local dir=$2

    show_menu_host_discovery
    read -p "Select Method: " method

    declare -A METHODS=(
        [1]="arp-ping-scan"
        [2]="udp-ping-scan"
        [3]="icmp-echo-ping-scan"
        [4]="icmp-echo-ping-sweep"
        [5]="icmp-timestamp-ping-scan"
        [6]="icmp-address-mask-ping-scan"
        [7]="tcp-syn-ping-scan"
        [8]="tcp-ack-ping-scan"
        [9]="ip-protocol-ping-scan"
    )

    if [[ "$method" == "10" ]]; then
        for m in "${METHODS[@]}"; do
            run_module "host_discovery" "$target" "$dir" "$m"
        done
    elif [[ "$method" == "0" ]]; then
        banner
        return
    elif [[ -n "${METHODS[$method]}" ]]; then
        run_module "host_discovery" "$target" "$dir" "${METHODS[$method]}"
    else
        echo -e "${RED}[!] Invalid option${RST}"
    fi
}

# Handler Port Discovery
function handle_port_discovery() {
    local target=$1
    local dir=$2

    show_menu_port_discovery
    read -p "Select Method: " method

    case $method in
    1) run_module "port_discovery" "$target" "$dir" "tcp-connect-scan" ;;
    2) run_module "port_discovery" "$target" "$dir" "stealth-scan" ;;
    3)
        while true; do
            show_menu_inverse_tcp_flag
            read -p "Select Inverse TCP Method: " inv
            case $inv in
            1)
                run_module "port_discovery" "$target" "$dir" "xmas-scan"
                break
                ;;
            2)
                run_module "port_discovery" "$target" "$dir" "fin-scan"
                break
                ;;
            3)
                run_module "port_discovery" "$target" "$dir" "null-scan"
                break
                ;;
            0) return ;;
            *) echo -e "${RED}[!] Invalid option${RST}" ;;
            esac
        done
        ;;
    4) run_module "port_discovery" "$target" "$dir" "tcp-maimon-scan" ;;
    5)
        while true; do
            show_menu_ack_probe_scan
            read -p "Select ACK Flag Probe Method: " ack
            case $ack in
            1)
                run_module "port_discovery" "$target" "$dir" "ack-flag-probe-scan"
                break
                ;;
            2)
                run_module "port_discovery" "$target" "$dir" "ttl-based-ack-flag-probe-scan"
                break
                ;;
            3)
                run_module "port_discovery" "$target" "$dir" "window-based-ack-flag-probe-scan"
                break
                ;;
            0) return ;;
            *) echo -e "${RED}[!] Invalid option${RST}" ;;
            esac
        done
        ;;
    6)
        read -p "$(echo -e ${YLW}[?]${RST} Enter Zombie IP:) " zombie_ip
        run_module "port_discovery" "$target" "$dir" "idle-scan:$zombie_ip"
        ;;
    7) run_module "port_discovery" "$target" "$dir" "udp-scan" ;;
    8) run_module "port_discovery" "$target" "$dir" "sctp-init-scan" ;;
    9) run_module "port_discovery" "$target" "$dir" "sctp-cookie-echo-scan" ;;
    10) run_module "port_discovery" "$target" "$dir" "service-version-detection" ;;
    0)
        banner
        return
        ;;
    *) echo -e "${RED}[!] Invalid option${RST}" ;;
    esac
}

# Handler OS Discovery
function handle_os_discovery() {
    local target=$1
    local dir=$2

    show_menu_os_discovery
    read -p "Select Method: " method

    case $method in
    1) run_module "os_discovery" "$target" "$dir" "default-os-detection" ;;
    2) run_module "os_discovery" "$target" "$dir" "script-engine-os-detection" ;;
    3) run_module "os_discovery" "$target" "$dir" "ipv6-os-detection" ;;
    0)
        banner
        return
        ;;
    *) echo -e "${RED}[!] Invalid option${RST}" ;;
    esac
}

# Handler Evasion
function handle_evasion() {
    local target=$1
    local dir=$2

    show_menu_evasion_techniques
    read -p "Select Method: " method

    declare -A METHODS=(
        [1]="packet-fragmentation-scan"
        [2]="source-routing-scan"
        [3]="source-port-manipulation-scan"
        [4]="ip-address-decoy-scan"
        [5]="ip-address-spoofing-scan"
        [6]="creating-custom-packets-scan"
        [7]="randomizing-host-order-scan"
        [8]="sending-bad-checksum-packets-scan"
        [9]="proxy-servers-scan"
        [10]="anonymizers-scan"
    )

    if [[ "$method" == "0" ]]; then
        banner
        return
    elif [[ -n "${METHODS[$method]}" ]]; then
        run_module "evasion" "$target" "$dir" "${METHODS[$method]}"
    else
        echo -e "${RED}[!] Invalid option${RST}"
    fi
}
