#!/bin/bash

################################################################################
# System Health Check Script
# Purpose: Comprehensive system health monitoring for IT Operations
# Author: George Miron
# Date: 2025
# Usage: ./system-health.sh
################################################################################

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Thresholds
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80
LOAD_THRESHOLD=4

################################################################################
# Functions
################################################################################

# Print header
print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}================================${NC}"
}

# Print status
print_status() {
    local status=$1
    local message=$2
    
    if [ "$status" = "OK" ]; then
        echo -e "${GREEN}[✓ OK]${NC} $message"
    elif [ "$status" = "WARNING" ]; then
        echo -e "${YELLOW}[⚠ WARNING]${NC} $message"
    elif [ "$status" = "CRITICAL" ]; then
        echo -e "${RED}[✗ CRITICAL]${NC} $message"
    fi
}

# Check CPU usage
check_cpu() {
    print_header "CPU Usage"
    
    # Get CPU usage (average across all cores)
    local cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print int($2)}')
    
    if [ "$cpu_usage" -lt "$CPU_THRESHOLD" ]; then
        print_status "OK" "CPU Usage: ${cpu_usage}%"
    elif [ "$cpu_usage" -lt 95 ]; then
        print_status "WARNING" "CPU Usage: ${cpu_usage}%"
    else
        print_status "CRITICAL" "CPU Usage: ${cpu_usage}%"
    fi
    
    # Show top processes
    echo -e "\n${BLUE}Top 5 CPU Consuming Processes:${NC}"
    ps aux --sort=-%cpu | head -6 | tail -5 | awk '{printf "  %-8s %-6s %-6s %s\n", $1, $3"%", $6"KB", $11}'
}

# Check memory usage
check_memory() {
    print_header "Memory Usage"
    
    # Get memory info
    local mem_info=$(free -h | grep Mem)
    local mem_total=$(echo $mem_info | awk '{print $2}')
    local mem_used=$(echo $mem_info | awk '{print $3}')
    local mem_available=$(echo $mem_info | awk '{print $7}')
    
    # Calculate percentage
    local mem_percent=$(free | grep Mem | awk '{printf("%.0f", ($3/$2) * 100)}')
    
    if [ "$mem_percent" -lt "$MEMORY_THRESHOLD" ]; then
        print_status "OK" "Memory Usage: ${mem_percent}% (${mem_used}/${mem_total})"
    elif [ "$mem_percent" -lt 95 ]; then
        print_status "WARNING" "Memory Usage: ${mem_percent}% (${mem_used}/${mem_total})"
    else
        print_status "CRITICAL" "Memory Usage: ${mem_percent}% (${mem_used}/${mem_total})"
    fi
    
    echo -e "\n${BLUE}Memory Details:${NC}"
    echo "  Total:     $mem_total"
    echo "  Used:      $mem_used"
    echo "  Available: $mem_available"
    
    # Show top memory consuming processes
    echo -e "\n${BLUE}Top 5 Memory Consuming Processes:${NC}"
    ps aux --sort=-%mem | head -6 | tail -5 | awk '{printf "  %-8s %-6s %-6s %s\n", $1, $4"%", $6"KB", $11}'
}

# Check disk usage
check_disk() {
    print_header "Disk Usage"
    
    echo -e "${BLUE}Mounted Filesystems:${NC}"
    
    df -h | tail -n +2 | while read line; do
        local usage=$(echo $line | awk '{print int($5)}')
        local filesystem=$(echo $line | awk '{print $1}')
        local mount=$(echo $line | awk '{print $6}')
        local size=$(echo $line | awk '{print $2}')
        local used=$(echo $line | awk '{print $3}')
        
        if [ "$usage" -lt "$DISK_THRESHOLD" ]; then
            print_status "OK" "$filesystem ($mount): ${usage}% used (${used}/${size})"
        elif [ "$usage" -lt 95 ]; then
            print_status "WARNING" "$filesystem ($mount): ${usage}% used (${used}/${size})"
        else
            print_status "CRITICAL" "$filesystem ($mount): ${usage}% used (${used}/${size})"
        fi
    done
}

# Check system load
check_load() {
    print_header "System Load"
    
    local load=$(uptime | awk -F'load average:' '{print $2}')
    local load_1=$(echo $load | awk '{print $1}' | sed 's/,//')
    local cpu_count=$(nproc)
    
    echo "  Load Average: $load"
    echo "  CPU Cores: $cpu_count"
    
    # Compare load to CPU count
    if (( $(echo "$load_1 < $cpu_count" | bc -l) )); then
        print_status "OK" "Load is healthy"
    elif (( $(echo "$load_1 < $cpu_count * 1.5" | bc -l) )); then
        print_status "WARNING" "Load is elevated"
    else
        print_status "CRITICAL" "Load is very high"
    fi
}

# Check network connectivity
check_network() {
    print_header "Network Status"
    
    # Check if network is up
    if ping -c 1 8.8.8.8 &> /dev/null; then
        print_status "OK" "Internet connectivity: Active"
    else
        print_status "WARNING" "Internet connectivity: Unavailable"
    fi
    
    # Show network interfaces
    echo -e "\n${BLUE}Network Interfaces:${NC}"
    ip link show | grep "^[0-9]" | awk '{print "  " $2}' | sed 's/:$//'
    
    # Show IP addresses
    echo -e "\n${BLUE}IP Addresses:${NC}"
    ip addr show | grep "inet " | awk '{print "  " $2}'
}

# Check system uptime
check_uptime() {
    print_header "System Uptime"
    
    local uptime=$(uptime -p)
    echo "  $uptime"
    
    # Show last reboot
    local last_reboot=$(who -b | awk '{print $3, $4}')
    echo "  Last reboot: $last_reboot"
}

# Check running services
check_services() {
    print_header "Critical Services"
    
    local services=("ssh" "cron" "systemd-resolved")
    
    for service in "${services[@]}"; do
        if systemctl is-active --quiet $service 2>/dev/null; then
            print_status "OK" "$service is running"
        else
            print_status "WARNING" "$service is not running"
        fi
    done
}

# Check disk I/O
check_disk_io() {
    print_header "Disk I/O"
    
    if command -v iostat &> /dev/null; then
        echo -e "${BLUE}Disk I/O Statistics:${NC}"
        iostat -x 1 2 | tail -n +4 | head -n -1
    else
        echo "  iostat not available (install sysstat package)"
    fi
}

# Generate summary
generate_summary() {
    print_header "System Health Summary"
    
    echo "  Hostname: $(hostname)"
    echo "  Kernel: $(uname -r)"
    echo "  OS: $(lsb_release -ds 2>/dev/null || echo 'Unknown')"
    echo "  Timestamp: $(date)"
}

################################################################################
# Main Execution
################################################################################

main() {
    echo -e "${BLUE}"
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║         SYSTEM HEALTH CHECK - IT OPERATIONS LAB            ║"
    echo "║                    $(date +%Y-%m-%d)                              ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo -e "${NC}\n"
    
    # Run all checks
    generate_summary
    echo ""
    check_uptime
    echo ""
    check_cpu
    echo ""
    check_memory
    echo ""
    check_disk
    echo ""
    check_load
    echo ""
    check_network
    echo ""
    check_services
    echo ""
    check_disk_io
    
    # Footer
    echo -e "\n${BLUE}════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}Report generated: $(date)${NC}"
    echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}\n"
}

# Run main function
main "$@"
