#!/bin/bash

# ==========================================
# High CPU Process Monitoring
# ==========================================

LOG_FILE="$HOME/process_monitor.log"

echo "========================================" > "$LOG_FILE"
echo "HIGH CPU PROCESS MONITORING" >> "$LOG_FILE"
echo "Date: $(date)" >> "$LOG_FILE"
echo "========================================" >> "$LOG_FILE"

echo "" >> "$LOG_FILE"
echo "Top CPU-consuming processes:" >> "$LOG_FILE"

ps -eo pid,ppid,user,%cpu,%mem,stat,cmd --sort=-%cpu | head -10 >> "$LOG_FILE"

echo "" >> "$LOG_FILE"
echo "Process tree:" >> "$LOG_FILE"

ps -ef --forest >> "$LOG_FILE"

echo "" >> "$LOG_FILE"
echo "Monitoring completed." >> "$LOG_FILE"

cat "$LOG_FILE"
