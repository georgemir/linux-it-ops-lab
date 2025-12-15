#!/bin/bash

################################################################################
# Security Audit Script
# Purpose: Basic security audit for Linux systems
# Author: George Miron
# Usage: ./security-audit.sh
################################################################################

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

REPORT_FILE="security-audit-$(date +%Y%m%d_%H%M%S).txt"

print_header() {
    echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║  SECURITY AUDIT REPORT                                    ║${NC}"
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

# Redirect output to file and console
exec > >(tee -a "$REPORT_FILE")
exec 2>&1

print_header

# System Information
print_section "System Information"
echo "  Hostname: $(hostname)"
echo "  Kernel: $(uname -r)"
echo "  OS: $(lsb_release -ds 2>/dev/null || echo 'Unknown')"
echo "  Audit Date: $(date)"

# User Accounts
print_section "User Accounts"
echo "  Total users: $(wc -l < /etc/passwd)"
echo "  Users with UID 0 (root): $(awk -F: '$3 == 0 {print $1}' /etc/passwd | wc -l)"

# Check for empty passwords
echo -e "\n  ${BLUE}Checking for empty passwords:${NC}"
if awk -F: '($2 == "" || $2 == "!") {print $1}' /etc/shadow | grep -q .; then
    print_status "WARNING" "Found accounts with empty passwords"
    awk -F: '($2 == "" || $2 == "!") {print "    - " $1}' /etc/shadow
else
    print_status "OK" "No accounts with empty passwords"
fi

# SSH Configuration
print_section "SSH Security"
if [ -f /etc/ssh/sshd_config ]; then
    echo "  SSH Configuration:"
    
    # Check SSH port
    ssh_port=$(grep "^Port" /etc/ssh/sshd_config | awk '{print $2}')
    if [ -z "$ssh_port" ]; then
        ssh_port="22"
    fi
    echo "    Port: $ssh_port"
    
    # Check root login
    root_login=$(grep "^PermitRootLogin" /etc/ssh/sshd_config | awk '{print $2}')
    if [ "$root_login" = "no" ]; then
        print_status "OK" "Root login disabled"
    else
        print_status "WARNING" "Root login enabled"
    fi
    
    # Check password authentication
    pwd_auth=$(grep "^PasswordAuthentication" /etc/ssh/sshd_config | awk '{print $2}')
    if [ "$pwd_auth" = "no" ]; then
        print_status "OK" "Password authentication disabled"
    else
        print_status "WARNING" "Password authentication enabled"
    fi
else
    print_status "ERROR" "SSH configuration not found"
fi

# Firewall Status
print_section "Firewall Status"
if systemctl is-active --quiet ufw; then
    print_status "OK" "UFW firewall is active"
    ufw status | head -5
elif systemctl is-active --quiet firewalld; then
    print_status "OK" "Firewalld is active"
else
    print_status "WARNING" "No firewall detected"
fi

# File Permissions
print_section "Critical File Permissions"
echo "  ${BLUE}Checking critical files:${NC}"

# Check /etc/passwd
perms=$(stat -c %a /etc/passwd)
if [ "$perms" = "644" ]; then
    print_status "OK" "/etc/passwd permissions: $perms"
else
    print_status "WARNING" "/etc/passwd permissions: $perms (should be 644)"
fi

# Check /etc/shadow
perms=$(stat -c %a /etc/shadow)
if [ "$perms" = "640" ] || [ "$perms" = "000" ]; then
    print_status "OK" "/etc/shadow permissions: $perms"
else
    print_status "WARNING" "/etc/shadow permissions: $perms (should be 640)"
fi

# Check /etc/sudoers
perms=$(stat -c %a /etc/sudoers)
if [ "$perms" = "440" ]; then
    print_status "OK" "/etc/sudoers permissions: $perms"
else
    print_status "WARNING" "/etc/sudoers permissions: $perms (should be 440)"
fi

# Sudo Access
print_section "Sudo Access"
echo "  ${BLUE}Users with sudo access:${NC}"
getent group sudo 2>/dev/null | cut -d: -f4 | tr ',' '\n' | sed 's/^/    - /'

# System Updates
print_section "System Updates"
if command -v apt &> /dev/null; then
    updates=$(apt list --upgradable 2>/dev/null | grep -c upgradable)
    if [ "$updates" -eq 0 ]; then
        print_status "OK" "System is up to date"
    else
        print_status "WARNING" "$updates packages available for update"
    fi
elif command -v yum &> /dev/null; then
    updates=$(yum check-update 2>/dev/null | grep -c "^[a-zA-Z]")
    if [ "$updates" -eq 0 ]; then
        print_status "OK" "System is up to date"
    else
        print_status "WARNING" "$updates packages available for update"
    fi
fi

# Failed Login Attempts
print_section "Failed Login Attempts"
if [ -f /var/log/auth.log ]; then
    failed=$(grep "Failed password" /var/log/auth.log 2>/dev/null | wc -l)
    echo "  Failed login attempts (last 24h): $failed"
    
    if [ "$failed" -gt 10 ]; then
        print_status "WARNING" "High number of failed login attempts"
    fi
fi

# Open Ports
print_section "Open Ports"
echo "  ${BLUE}Listening services:${NC}"
ss -tlnp 2>/dev/null | grep LISTEN | awk '{print "    " $4}' | sort -u

# Running Services
print_section "Critical Services"
services=("ssh" "cron" "systemd-resolved")
for service in "${services[@]}"; do
    if systemctl is-active --quiet $service 2>/dev/null; then
        print_status "OK" "$service is running"
    else
        print_status "WARNING" "$service is not running"
    fi
done

# Disk Encryption
print_section "Disk Encryption"
if lsblk -o NAME,CRYPT | grep -q crypt; then
    print_status "OK" "Encrypted volumes detected"
else
    print_status "WARNING" "No encrypted volumes detected"
fi

# SELinux/AppArmor
print_section "Mandatory Access Control"
if command -v getenforce &> /dev/null; then
    selinux_status=$(getenforce)
    echo "  SELinux status: $selinux_status"
elif command -v aa-status &> /dev/null; then
    echo "  AppArmor is installed"
else
    print_status "WARNING" "No MAC system detected"
fi

# Report Footer
echo -e "\n${BLUE}════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}Report saved to: $REPORT_FILE${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}\n"
