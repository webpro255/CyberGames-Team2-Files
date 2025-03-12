#!/bin/bash

# Secure FTP Server (vsftpd) Setup Script
# NCAE Cyber Games Competition
# Run ONLY on FTP Server

echo "[START] FTP Server installation and security setup."

# Step 1: Update packages and install vsftpd
echo "[INFO] Updating system and installing vsftpd..."
sudo apt update && sudo apt install vsftpd -y

# Enable vsftpd service at startup
sudo systemctl enable vsftpd

# Step 2: Secure FTP server configuration
echo "[INFO] Configuring secure FTP server settings..."

# Backup original configuration file
sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.backup

# Write secure FTP settings into vsftpd.conf
sudo bash -c 'cat << EOF > /etc/vsftpd.conf
anonymous_enable=NO
write_enable=YES
local_enable=YES
chroot_local_user=YES
allow_writeable_chroot=YES
EOF'

# Step 3: Restart vsftpd to apply settings
echo "[INFO] Restarting FTP service (vsftpd)..."
sudo systemctl restart vsftpd

# Check FTP service status
sudo systemctl status vsftpd | grep Active

echo "[COMPLETE] FTP server securely installed and configured."

