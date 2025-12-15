#!/bin/bash

################################################################################
# Automated Backup Script
# Purpose: Create compressed backups with rotation
# Author: George Miron
# Usage: ./backup-script.sh [source] [destination] [retention_days]
################################################################################

set -euo pipefail

# Default values
BACKUP_DIR="${2:-.}"
RETENTION_DAYS="${3:-7}"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"
LOG_FILE="$BACKUP_DIR/backup_$TIMESTAMP.log"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

################################################################################
# Functions
################################################################################

log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1" | tee -a "$LOG_FILE"
    exit 1
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1" | tee -a "$LOG_FILE"
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1" | tee -a "$LOG_FILE"
}

# Validate inputs
validate_inputs() {
    if [ -z "${1:-}" ]; then
        error "Usage: $0 <source_directory> [backup_destination] [retention_days]"
    fi
    
    if [ ! -d "$1" ]; then
        error "Source directory does not exist: $1"
    fi
    
    if [ ! -d "$BACKUP_DIR" ]; then
        error "Backup destination does not exist: $BACKUP_DIR"
    fi
}

# Create backup
create_backup() {
    local source="$1"
    
    log "Starting backup of: $source"
    log "Backup file: $BACKUP_FILE"
    
    if tar -czf "$BACKUP_FILE" -C "$(dirname "$source")" "$(basename "$source")" 2>> "$LOG_FILE"; then
        success "Backup created successfully"
        
        # Get file size
        local size=$(du -h "$BACKUP_FILE" | cut -f1)
        log "Backup size: $size"
    else
        error "Failed to create backup"
    fi
}

# Rotate old backups
rotate_backups() {
    log "Rotating backups older than $RETENTION_DAYS days"
    
    local count=0
    while IFS= read -r file; do
        rm -f "$file"
        log "Deleted old backup: $file"
        ((count++))
    done < <(find "$BACKUP_DIR" -name "backup_*.tar.gz" -mtime +$RETENTION_DAYS)
    
    if [ $count -gt 0 ]; then
        success "Deleted $count old backup(s)"
    else
        log "No old backups to delete"
    fi
}

# Verify backup
verify_backup() {
    log "Verifying backup integrity"
    
    if tar -tzf "$BACKUP_FILE" > /dev/null 2>&1; then
        success "Backup verification passed"
    else
        error "Backup verification failed"
    fi
}

# Generate report
generate_report() {
    log "Generating backup report"
    
    echo "" >> "$LOG_FILE"
    echo "=== BACKUP REPORT ===" >> "$LOG_FILE"
    echo "Backup Date: $(date)" >> "$LOG_FILE"
    echo "Source: $1" >> "$LOG_FILE"
    echo "Destination: $BACKUP_FILE" >> "$LOG_FILE"
    echo "Size: $(du -h "$BACKUP_FILE" | cut -f1)" >> "$LOG_FILE"
    echo "Files in backup: $(tar -tzf "$BACKUP_FILE" | wc -l)" >> "$LOG_FILE"
    echo "Retention: $RETENTION_DAYS days" >> "$LOG_FILE"
    echo "===================" >> "$LOG_FILE"
    
    success "Report generated: $LOG_FILE"
}

################################################################################
# Main Execution
################################################################################

main() {
    echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║     AUTOMATED BACKUP SCRIPT            ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════╝${NC}\n"
    
    validate_inputs "$@"
    
    local source="$1"
    
    create_backup "$source"
    verify_backup
    rotate_backups
    generate_report "$source"
    
    echo -e "\n${GREEN}Backup process completed successfully!${NC}"
    echo -e "Log file: $LOG_FILE\n"
}

main "$@"
