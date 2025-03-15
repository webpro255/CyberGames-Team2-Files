#!/bin/bash

# SSH Key Setup Script for Team 17
# - Sets up SSH keys for team members
# - Secures SSH by disabling password authentication
# - Restarts SSH service

echo "[+] Starting Team 17 SSH Key Setup..."

# Define Team 17 Members (Change these usernames as needed)
declare -a TEAM17_USERS=(
    "techpro"
    "mellow"
    "anihacc"
    "teamate1"
    "teamate2"
    "teamate3"
    "teamate4"
)

# Define Public Keys for Team 17 (Replace FAKE_PUB_KEY_HERE with actual keys)
declare -A USER_KEYS
USER_KEYS["techpro"]="FAKE_PUB_KEY_HERE"
USER_KEYS["mellow"]="FAKE_PUB_KEY_HERE"
USER_KEYS["anihacc"]="FAKE_PUB_KEY_HERE"
USER_KEYS["teamate1"]="FAKE_PUB_KEY_HERE"
USER_KEYS["teamate2"]="FAKE_PUB_KEY_HERE"
USER_KEYS["teamate3"]="FAKE_PUB_KEY_HERE"
USER_KEYS["teamate4"]="FAKE_PUB_KEY_HERE"

# Function to create users and set up SSH keys
setup_user() {
    local USERNAME=$1
    local PUB_KEY=${USER_KEYS[$USERNAME]}

    # Create user if not exists
    if ! id "$USERNAME" &>/dev/null; then
        echo "[+] Creating user: $USERNAME"
        useradd -m -s /bin/bash "$USERNAME"
    fi

    # Set up SSH directory
    mkdir -p /home/$USERNAME/.ssh
    chmod 700 /home/$USERNAME/.ssh

    # Add public key
    if [[ ! -z "$PUB_KEY" ]] && [[ "$PUB_KEY" != "FAKE_PUB_KEY_HERE" ]]; then
        echo "$PUB_KEY" > /home/$USERNAME/.ssh/authorized_keys
        chmod 600 /home/$USERNAME/.ssh/authorized_keys
        chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh
        echo "[✔] SSH key added for: $USERNAME"
    else
        echo "[⚠] No public key provided for: $USERNAME (Skipping)"
    fi
}

# Loop through each team member and set up keys
for USER in "${TEAM17_USERS[@]}"; do
    setup_user "$USER"
done

# Secure SSH configuration
# Secure SSH configuration
echo "[+] Securing SSH configuration..."
sed -i 's/^#\?PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^#\?ChallengeResponseAuthentication .*/ChallengeResponseAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^#\?PubkeyAuthentication .*/PubkeyAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^#\?PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config


# Restart SSH service
echo "[+] Restarting SSH service..."
systemctl restart sshd

echo "[✔] Team 17 SSH Key Setup Completed!"
