#!/bin/bash

################################################################################
# Disk Usage Report Script
# Purpose: Generate detailed disk usage reports
# Author: George Miron
# Usage: ./disk-usage.sh [directory] [threshold]
################################################################################

set -euo pipefail

# Default values
TARGET_DIR="${1:-.}"
THRESHOLD="${2:-80}"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

################################################################################
# Functions
################################################################################

print_header() {
    echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║  DISK USAGE REPORT - $1${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}\n"
}

# Check if directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${RED}Error: Directory not found: $TARGET_DIR${NC}"
    exit 1
fi

print_header "$(date +%Y-%m-%d)"

# Filesystem usage
echo -e "${BLUE}Filesystem Usage:${NC}"
df -h "$TARGET_DIR" | tail -1 | awk '{
    usage = int($5)
    printf "  Total: %s | Used: %s | Available: %s | Usage: %s\n", $2, $3, $4, $5
}'

echo ""
echo -e "${BLUE}Top 10 Largest Directories:${NC}"
du -sh "$TARGET_DIR"/* 2>/dev/null | sort -rh | head -10 | nl

echo ""
echo -e "${BLUE}Top 10 Largest Files:${NC}"
find "$TARGET_DIR" -type f -exec du -h {} + 2>/dev/null | sort -rh | head -10 | nl

echo ""
echo -e "${BLUE}Directory Count:${NC}"
echo "  Total directories: $(find "$TARGET_DIR" -type d 2>/dev/null | wc -l)"
echo "  Total files: $(find "$TARGET_DIR" -type f 2>/dev/null | wc -l)"

echo ""
echo -e "${BLUE}Report generated: $(date)${NC}\n"
