# GhostScan

GhostScan is a lightweight penetration testing tool that acts as a wrapper for **Nmap**. It simplifies network scanning by providing an intuitive, menu-driven interface using `fzf`, allowing users to easily choose scan types without remembering long command syntax.

---

## Features

Currently, GhostScan supports the following modules and techniques:

### 1. Host Discovery

Identify active hosts in a network using various Nmap ping techniques:

* ARP Ping Scan
* UDP Ping Scan
* ICMP Echo Ping Scan
* ICMP Echo Ping Sweep
* ICMP Timestamp Ping Scan
* ICMP Address Mask Ping Scan
* TCP SYN Ping Scan
* TCP ACK Ping Scan
* IP Protocol Ping Scan
* Run All Methods

### 2. Port Discovery

Discover open ports and running services using advanced Nmap scan methods:

* TCP Connect / Full-Open Scan
* Stealth Scan (Half-Open Scan)
* Xmas Scan
* FIN Scan
* NULL Scan
* TCP Maimon Scan
* ACK Flag Probe Scan
* TTL-Based ACK Flag Probe Scan
* Window-Based ACK Flag Probe Scan
* IDLE / IPID Header Scan (requires Zombie IP)
* UDP Scan
* SCTP INIT Scan
* SCTP COOKIE ECHO Scan
* Service Version Detection

### 3. OS Discovery

Identify operating systems of target hosts:

* Default OS Detection
* Script Engine OS Detection
* IPv6 OS Detection

### 4. Evasion Techniques

Bypass firewalls and IDS/IPS using Nmap evasion features:

* SYN/FIN Scanning Using IP Fragments
* Source Port Manipulation
* IP Address Decoy
* MAC Address Spoofing
* Randomizing Host Order
* Sending Bad Checksum Packets
* Proxy Servers
* Anonymizers

---

## Requirements

* Linux / Unix-based OS (tested on Kali Linux)
* `nmap`
* `fzf` (for interactive menu)
* Bash (>= 4.0)

Install dependencies on Debian-based systems:

```bash
sudo apt update
sudo apt install nmap fzf -y
```

---

## Usage

1. Clone the repository:

```bash
git clone https://github.com/xRiot45/GhostScan.git
cd GhostScan
```

2. Run the tool with root privileges:

```bash
sudo bash src/main.sh
```

3. Enter the target IP or range when prompted.

4. Use the interactive menu (navigated with **arrow keys**) to select scanning modules and techniques.

---

## Example

```bash
sudo bash src/main.sh
```

**Output:**

```
[?] Enter target IP/Range: <ip-address-target>

Host Discovery >
  ▸ ARP Ping Scan
    UDP Ping Scan
    ICMP Echo Ping Scan
    TCP SYN Ping Scan
    Run All Methods
    Back
```

---

## Disclaimer

GhostScan is intended for **educational and authorized penetration testing purposes only**. Unauthorized use of this tool on networks you do not own or have explicit permission to test is illegal.
