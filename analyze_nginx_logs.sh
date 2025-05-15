#!/bin/bash

LOG_FILE="/var/log/nginx/access.log"

if [ ! -f "$LOG_FILE" ]; then
  echo "Nginx access log not found at $LOG_FILE"
  exit 1
fi

echo "===== Nginx Log Analysis Report ====="
echo "Log file: $LOG_FILE"
echo

echo "➤ Total Requests:"
wc -l < "$LOG_FILE"
echo

echo "➤ Top 5 IPs:"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5
echo

echo "➤ Top 5 Requested URLs:"
awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5
echo

echo "➤ HTTP Status Codes Summary:"
awk '{print $9}' "$LOG_FILE" | grep -E '^[0-9]{3}$' | sort | uniq -c | sort -nr
echo

echo "======================================"

