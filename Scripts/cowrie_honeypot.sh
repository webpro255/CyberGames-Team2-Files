#!/bin/bash

# Cowrie Honeypot Setup Script (Ubuntu)
# Use ONLY on Dedicated Honeypot Server (Isolated VM)

echo "[START] Setting up Cowrie SSH Honeypot."

# Step 1: Update system packages
echo "[INFO] Updating system packages..."
sudo apt update -y

# Step 2: Install dependencies (Python, git, pip)
echo "[INFO] Installing dependencies (Python, pip, git)..."
sudo apt install python3 python3-pip python3-venv git -y

# Step 3: Clone Cowrie Honeypot Repository
echo "[INFO] Cloning Cowrie..."
cd ~
git clone https://github.com/cowrie/cowrie.git
cd cowrie

# Step 4: Install Python requirements for Cowrie
echo "[INFO] Installing Cowrie requirements..."
python3 -m venv cowrie-env
source cowrie-env/bin/activate
pip install --upgrade pip
pip install -r requirements.txt

# Step 4: Start Cowrie SSH Honeypot
echo "[INFO] Starting Cowrie SSH honeypot..."
bin/cowrie start

# Verify that Cowrie is running
echo "[INFO] Checking if Cowrie is running..."
sleep 3
if pgrep -f "twistd -n cowrie" >/dev/null; then
    echo "[SUCCESS] Cowrie honeypot is running!"
else
    echo "[ERROR] Cowrie failed to start. Check logs at ~/cowrie/var/log/cowrie/cowrie.log"
fi

