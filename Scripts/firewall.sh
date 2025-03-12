#!/bin/bash

# Firewall Security Setup Script (Ubuntu Servers)
# For NCAE Cyber Games Competition

echo "[START] Configuring UFW Firewall rules."

# Step 1: Update the package list and install UFW (if not installed)
echo "[INFO] Installing UFW firewall..."
sudo apt update
sudo apt install ufw -y

# Step 2: Set default firewall rules
echo "[INFO] Setting default firewall rules to deny all incoming and allow outgoing traffic..."
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Step 3: Allow essential services (SSH, HTTP, HTTPS)
echo "[INFO] Allowing SSH (port 22)..."
sudo ufw allow ssh

echo "[INFO] Allowing HTTP (port 80)..."
sudo ufw allow http

echo "[INFO] Allowing HTTPS (port 443)..."
sudo ufw allow https

# Optional: Allow additional services as needed (uncomment if needed)
# sudo ufw allow ftp          # FTP (port 21)
# sudo ufw allow mysql        # MySQL (port 3306)
# sudo ufw allow 53           # DNS (port 53)

# Step 4: Enable the firewall (this will prompt confirmation)
echo "[INFO] Enabling firewall..."
sudo ufw --force enable

# Step 5: Check firewall status
echo "[INFO] Current firewall status:"
sudo ufw status verbose

echo "[COMPLETE] Firewall setup and rules applied successfully."

