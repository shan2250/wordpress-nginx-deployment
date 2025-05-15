#!/bin/bash
LOGFILE=${1:-/var/log/nginx/access.log}

echo "Top IPs:"
awk '{print $1}' $LOGFILE | sort | uniq -c | sort -nr | head

echo -e "\nTop requested URLs:"
awk '{print $7}' $LOGFILE | sort | uniq -c | sort -nr | head

echo -e "\nStatus Codes:"
awk '{print $9}' $LOGFILE | sort | uniq -c | sort -nr
