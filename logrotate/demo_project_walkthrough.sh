#!/bin/bash

echo "===== 🧠 1. Introduction ====="
echo "This project demonstrates deploying a WordPress site using Docker,"
echo "protected by an Nginx reverse proxy, with IP-restricted admin access,"
echo "log rotation, and automated log analysis."
sleep 3

echo
echo "===== 🧱 2. Project Structure Overview ====="
tree . -L 2
echo
echo "docker-compose.yml     → Manages WordPress, MySQL, and Nginx containers."
echo "nginx/                 → Custom Nginx config (reverse proxy + IP restriction)."
echo "logrotate/             → Nginx log rotation configuration."
echo "scripts/analyze_logs.sh → Script to analyze access logs."
echo "verify_wordpress_deployment.sh → Full deployment verification script."
echo "readme.md              → Project documentation."
sleep 5

echo
echo "===== ⚙️ 3. Docker Setup & Launch ====="
echo "> Showing docker-compose.yml..."
cat docker-compose.yml
sleep 2

echo "> Starting containers..."
docker-compose up -d
sleep 3

echo "> Running containers:"
docker ps
sleep 3

echo
echo "===== 🌐 4. Nginx Reverse Proxy Test ====="
echo "> Checking Nginx reverse proxy response:"
curl -I http://localhost
sleep 2

echo "> Visit your site at: http://<your-EC2-public-IP>"
sleep 2

echo
echo "===== 🔐 5. Admin Login IP Restriction ====="
echo "> Trying to access /wp-login.php:"
curl -I http://localhost/wp-login.php
sleep 2

echo "> Nginx config that restricts access:"
grep -A 4 "location ~\* /wp-login.php" nginx/nginx.conf
sleep 3

echo
echo "===== 📂 6. Log Rotation Setup ====="
echo "> Showing logrotate config:"
cat logrotate/nginx-logrotate.conf
sleep 3

echo "> Forcing log rotation..."
sudo logrotate -f logrotate/nginx-logrotate.conf
sleep 2

echo "> Verifying rotated logs:"
ls -lh /var/log/nginx/
sleep 3

echo
echo "===== 📊 7. Log Analysis Script ====="
echo "> Running log analysis script:"
./analyze_nginx_logs.sh
sleep 3

echo
echo "===== ✅ 8. Full Verification Script ====="
echo "> Running verification script:"
./verify_wordpress_deployment.sh
sleep 3

echo "🎬 Demo complete. All steps verified."
