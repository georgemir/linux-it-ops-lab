#!/bin/bash

################################################################################
# Network Diagnostics Script
# Purpose: Comprehensive network health check
# Author: George Miron
# Usage: ./network-check.sh
################################################################################

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() {
    echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║  NETWORK DIAGNOSTICS REPORT                               ║${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}\n"
}

print_section() {
    echo -e "\n${BLUE}▶ $1${NC}"
    echo -e "${BLUE}─────────────────────────────────────────────────────────${NC}"
}

print_status() {
    local status=$1
    local message=$2
    
    if [ "$status" = "OK" ]; then
        echo -e "${GREEN}[✓]${NC} $message"
    elif [ "$status" = "WARNING" ]; then
        echo -e "${YELLOW}[⚠]${NC} $message"
    else
        echo -e "${RED}[✗]${NC} $message"
    fi
}

print_header

# System Information
print_section "System Information"
echo "  Hostname: $(hostname)"
echo "  Kernel: $(uname -r)"
echo "  Uptime: $(uptime -p)"

# Network Interfaces
print_section "Network Interfaces"
ip link show | grep "^[0-9]" | while read line; do
    iface=$(echo $line | awk '{print $2}' | sed 's/:$//')
    state=$(echo $line | grep -o "UP\|DOWN" | head -1)
    
    if [ "$state" = "UP" ]; then
        print_status "OK" "$iface is UP"
    else
        print_status "ERROR" "$iface is DOWN"
    fi
done

# IP Addresses
print_section "IP Addresses"
ip addr show | grep "inet " | awk '{print "  " $2}'

# Default Gateway
print_section "Default Gateway"
ip route show | grep default | awk '{print "  Gateway: " $3}'

# DNS Configuration
print_section "DNS Configuration"
if [ -f /etc/resolv.conf ]; then
    grep "^nameserver" /etc/resolv.conf | awk '{print "  " $0}'
else
    echo "  No DNS configuration found"
fi

# Internet Connectivity
print_section "Internet Connectivity"
if ping -c 1 8.8.8.8 &> /dev/null; then
    print_status "OK" "Internet connectivity: Active"
else
    print_status "ERROR" "Internet connectivity: Unavailable"
fi

# DNS Resolution
print_section "DNS Resolution"
if nslookup google.com &> /dev/null; then
    print_status "OK" "DNS resolution: Working"
else
    print_status "ERROR" "DNS resolution: Failed"
fi

# Network Statistics
print_section "Network Statistics"
echo -e "  ${BLUE}Interface Statistics:${NC}"
netstat -i 2>/dev/null | tail -n +3 | awk '{printf "    %-10s RX: %10s TX: %10s\n", $1, $4, $10}'

# Open Ports
print_section "Listening Ports"
echo -e "  ${BLUE}TCP Ports:${NC}"
ss -tlnp 2>/dev/null | grep LISTEN | awk '{print "    " $4}' | sort -u | head -10

# Network Connections
print_section "Active Connections"
echo "  Total connections: $(ss -tan 2>/dev/null | grep ESTAB | wc -l)"
echo "  Listening ports: $(ss -tln 2>/dev/null | grep LISTEN | wc -l)"

# Routing Table
print_section "Routing Table"
ip route show | head -5 | awk '{print "  " $0}'

# Network Performance
print_section "Network Performance"
if command -v iperf3 &> /dev/null; then
    echo "  iperf3 is available for bandwidth testing"
else
    echo "  iperf3 not installed (install for bandwidth testing)"
fi

# Firewall Status
print_section "Firewall Status"
if command -v ufw &> /dev/null; then
    ufw status | head -1
elif command -v firewall-cmd &> /dev/null; then
    firewall-cmd --state
else
    echo "  No firewall management tool found"
fi

# Report Footer
echo -e "\n${BLUE}════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}Report generated: $(date)${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}\n"
