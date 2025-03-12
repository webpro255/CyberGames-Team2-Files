#!/bin/bash

# DNS Server Secure Setup Script
# Installs and configures BIND9 securely for NCAE Cyber Games

echo "[START] DNS Server (BIND9) Installation and Security Setup."

# === Step 1: Update system and install BIND9 ===
echo "[INFO] Installing BIND9 DNS Server..."
sudo apt update && sudo apt install bind9 -y

# Enable BIND9 to start automatically
sudo systemctl enable bind9

# Step 2: Secure BIND9 Configuration (restrict queries and recursion)
echo "[INFO] Configuring secure DNS settings..."
sudo cp /etc/bind/named.conf.options /etc/bind/named.conf.options.backup

# Overwrite named.conf.options with secure settings
sudo bash -c 'cat << EOF > /etc/bind/named.conf.options
options {
    directory "/var/cache/bind";
    allow-query { localhost; 192.168.0.0/24; };
    recursion no;
    allow-transfer { none; };
};
'

# Step 3: Restart BIND9 to apply changes
echo "[INFO] Restarting BIND9 service..."
sudo systemctl restart bind9

# Step 4: Check if DNS service is running
sudo systemctl status bind9 | grep Active

echo "[COMPLETE] DNS Server has been installed, secured, and started successfully."

