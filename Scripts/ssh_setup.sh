#!/bin/bash

# SSH Security and User Account Setup Script
# For NCAE Cyber Games Competition

echo "[START] SSH setup and user creation script."

# === Step 1: Create user accounts ===
# Replace usernames and passwords as needed below:
declare -A users=(
  ["webpro"]="NewStrongPassword1"
  ["user2"]="NewStrongPassword2"
  ["user3"]="NewStrongPassword3"
  ["user4"]="NewStrongPassword4"
  ["user5"]="NewStrongPassword5"
  ["user6"]="NewStrongPassword6"
  ["user7"]="NewStrongPassword7"
  ["user8"]="NewStrongPassword8"
  ["user9"]="NewStrongPassword9"
  ["user10"]="NewStrongPassword10"
)

for username in "${!users[@]}"; do
    password=${users[$username]}
    echo "[INFO] Creating user: $username"
    
    # Add user and include in sudo group
    sudo useradd -m -s /bin/bash -G sudo "$username"
    
    # Set user password
    echo "$username:$password" | sudo chpasswd

    echo "[SUCCESS] User $username created and password set."
done

echo "[COMPLETE] All users created."

# === Step 2: Secure SSH Configuration ===
echo "[INFO] Securing SSH configuration."

# Backup original SSH config
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup

# Disable root login via SSH
sudo sed -i '/^#*PermitRootLogin/c\PermitRootLogin no' /etc/ssh/sshd_config

# Enable password authentication
sudo sed -i '/^#*PasswordAuthentication/c\PasswordAuthentication yes' /etc/ssh/sshd_config

# Explicitly allow only these users to log in
allowed_users=$(printf "%s " "${!users[@]}")
echo "AllowUsers $allowed_users" | sudo tee -a /etc/ssh/sshd_config

# Restart SSH to apply changes
sudo systemctl restart sshd
sudo systemctl status sshd | grep Active

# === Step 3: Install Fail2ban for protection ===
echo "[INFO] Installing fail2ban."
sudo apt update
sudo apt install fail2ban -y
sudo systemctl enable --now fail2ban
sudo systemctl status fail2ban | grep Active

echo "[SUCCESS] SSH setup and user account creation completed successfully."
