#!/bin/bash

echo "===== WordPress + Nginx Deployment Verification ====="

# Container name check
echo -n "[1] WordPress container running: "
docker ps --format '{{.Names}}' | grep -q "wordpress-nginx-wordpress-1" && echo "✔" || echo "✘"

echo -n "[2] Nginx container running: "
docker ps --format '{{.Names}}' | grep -q "wordpress-nginx-nginx-1" && echo "✔" || echo "✘"

# Check if site returns 200
echo -n "[3] Nginx reverse proxy responds (200 OK): "
curl -I -s http://localhost | grep -q "200 OK" && echo "✔" || echo "✘"

# IP restriction on wp-login.php (expecting 403 from localhost)
echo -n "[4] Admin login protected (403 if IP not allowed): "
curl -I -s http://localhost/wp-login.php | grep -q "403 Forbidden" && echo "✔" || echo "✘"

# Nginx log exists
echo -n "[5] Nginx access log found: "
docker exec wordpress-nginx-nginx-1 test -f /var/log/nginx/access.log && echo "✔" || echo "✘"

# Log rotation check — check for rotated files
echo -n "[6] Log rotation configured: "
if ls /var/log/nginx/access.log.* >/dev/null 2>&1 && ls /var/log/nginx/error.log.* >/dev/null 2>&1; then
    echo "✔"
else
    echo "✘"
fi

# Log analysis script exists
echo -n "[7] Log analysis script exists: "
test -f ./analyze_nginx_logs.sh && echo "✔" || echo "✘"

# Docker Compose file check
echo -n "[8] Docker Compose file present: "
test -f ./docker-compose.yml && echo "✔" || echo "✘"

echo "====================================================="

