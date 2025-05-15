# WordPress + Nginx Deployment (Dockerized)

This project demonstrates the deployment of a sample WordPress website using **Docker Compose**, protected by an **Nginx reverse proxy**, with **admin login access restricted to a specific IP**, and automated **log rotation** and **log analysis**.

---

## ✅ Features

- 🐳 Docker Compose-based deployment of WordPress + Nginx
- 🔐 Nginx reverse proxy with IP-restricted admin login (`/wp-login.php`)
- 📄 Log rotation configured for Nginx logs (`access.log` and `error.log`)
- 📊 Custom log analysis script to generate traffic reports
- 🔁 Automated deployment verification script
- ☁️ Easily extensible to cloud CI/CD pipelines

---

## 📁 Project Structure

```
wordpress-nginx/
├── analyze_nginx_logs.sh           # Log analysis script
├── docker-compose.yml              # Docker Compose config for WordPress + Nginx
├── logrotate/
│   └── nginx-logrotate.conf        # Custom logrotate configuration
├── nginx/
│   └── ...                         # Nginx config files (proxy, site confs)
├── verify_wordpress_deployment.sh # Validation script for deployment checks
└── README.md                       # Project documentation (this file)
```

---

## 🚀 Usage

### 1. Clone Repository

```bash
git clone https://github.com/shan2250/wordpress-nginx-deployment.git
cd wordpress-nginx-deployment
```

### 2. Start Deployment

```bash
docker-compose up -d
```

### 3. Verify Everything Works

```bash
./verify_wordpress_deployment.sh
```

### 4. Analyze Logs

```bash
./analyze_nginx_logs.sh
```

---

## 🔄 Log Rotation

Logs are rotated daily using a custom `logrotate` config located at `logrotate/nginx-logrotate.conf`. It retains 14 compressed logs and sends `USR1` signal to Nginx to reopen logs post-rotation.

---

## 🔒 Admin Login Restriction

Access to `/wp-login.php` is protected via IP restriction configured in the Nginx site config. Modify the allowed IP in the Nginx conf as needed.

---

## 📜 License

MIT License

---

## 🛠️ Author

- [Shahrukh Sayyad(https://github.com/shan2250)

