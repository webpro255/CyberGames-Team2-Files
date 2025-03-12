#!/bin/bash

# MySQL Secure Installation Script
# For NCAE Cyber Games Competition
# Run this script ONLY on the dedicated MySQL Database Server.

echo "[START] Securing MySQL Database Server."

# Step 1: Update system packages and install MySQL Server
echo "[INFO] Installing MySQL server..."
sudo apt update
sudo apt install mysql-server -y

# Ensure MySQL is started and enabled to start on boot
sudo systemctl enable mysql
sudo systemctl start mysql

# Step 2: Run MySQL Secure Installation (Interactive setup)
echo "[ACTION REQUIRED] Starting mysql_secure_installation wizard."

sudo mysql_secure_installation

# When prompted by mysql_secure_installation, follow these best practices:
# - Set a STRONG root password.
# - Remove anonymous users (choose YES).
# - Disallow root login remotely (choose YES).
# - Remove test database and access (choose YES).
# - Reload privilege tables now (choose YES).

echo "[COMPLETE] MySQL installed and secured successfully."

# Check if MySQL service is running properly
sudo systemctl status mysql | grep Active

