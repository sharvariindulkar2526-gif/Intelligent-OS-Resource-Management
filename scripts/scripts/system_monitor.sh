#!/bin/bash

# ==========================================
# System Disk and Memory Monitoring
# ==========================================

LOG_DIR="$HOME/system_logs"
mkdir -p "$LOG_DIR"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$LOG_DIR/system_$TIMESTAMP.log"

echo "========================================" >> "$LOG_FILE"
echo "SYSTEM RESOURCE MONITORING" >> "$LOG_FILE"
echo "Timestamp: $(date)" >> "$LOG_FILE"
echo "========================================" >> "$LOG_FILE"

echo "" >> "$LOG_FILE"
echo "DISK USAGE:" >> "$LOG_FILE"
df -h >> "$LOG_FILE"

echo "" >> "$LOG_FILE"
echo "MEMORY INFORMATION:" >> "$LOG_FILE"
free -h >> "$LOG_FILE"

echo "" >> "$LOG_FILE"
echo "MEMORY AVAILABLE:" >> "$LOG_FILE"
free -h | awk '/Mem:/ {print $7}' >> "$LOG_FILE"

echo "" >> "$LOG_FILE"
echo "Compressing logs older than 7 days..." >> "$LOG_FILE"

find "$LOG_DIR" -type f -name "*.log" -mtime +7 -exec gzip {} \;

echo "Monitoring completed at $(date)" >> "$LOG_FILE"

echo "Log created: $LOG_FILE"
