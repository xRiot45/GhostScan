# Main Menu
function show_menu() {
    echo -e "   "
    echo -e "   ${GRN}1${RST}) Host Discovery                               "
    echo -e "   ${GRN}2${RST}) Port & Service Discovery                     "
    echo -e "   ${GRN}3${RST}) OS Detection                                 "
    echo -e "   ${GRN}4${RST}) IDS/Firewall Evasion Techniques              "
    echo -e "   ${GRN}4${RST}) Exit                                         "
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
    echo -e "   ${GRN}10${RST}) Service Version Detection           "
    echo -e "   ${GRN}0${RST}) Back                                 "
    echo -e "   "
}

# Submenu: OS Discovery
function show_menu_os_discovery() {
    echo -e "   "
    echo -e "   ${GRN}1${RST}) Default OS Detection         "
    echo -e "   ${GRN}2${RST}) Script Engine OS Detection   "
    echo -e "   ${GRN}3${RST}) IPv6 OS Detection           "
    echo -e "   ${GRN}0${RST}) Back                         "
    echo -e "   "
}

# Submenu: IDS/Firewall Evasion Techniques
function show_menu_evasion_techniques() {
    echo -e "   "
    echo -e "   ${GRN}1${RST}) SYN/FIN Scanning Using IP Fragments  "
    echo -e "   ${GRN}2${RST}) Source Routing Scan                  "
    echo -e "   ${GRN}3${RST}) Source Port Manipulation Scan        "
    echo -e "   ${GRN}4${RST}) IP Address Decoy Scan                "
    echo -e "   ${GRN}5${RST}) IP Address Spoofing Scan             "
    echo -e "   ${GRN}6${RST}) Creating Custom Packets Scan         "
    echo -e "   ${GRN}7${RST}) Randomizing Host Order Scan          "
    echo -e "   ${GRN}8${RST}) Sending Bad Checksum Packets Scan    "
    echo -e "   ${GRN}9${RST}) Proxy Servers Scan                   "
    echo -e "   ${GRN}10${RST}) Anonymizers Scan                    "
    echo -e "   ${GRN}0${RST}) Back                                 "
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
