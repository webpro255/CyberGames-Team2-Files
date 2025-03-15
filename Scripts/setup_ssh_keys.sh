#!/bin/bash

echo "[+] Starting SSH Key Setup..."

# Define users (27 scoring users + 7 team members)
declare -a USERS=(
    # 27 Scoring Users (DO NOT REMOVE)
    "camille_jenatzy"
    "gaston_chasseloup"
    "leon_serpollet"
    "william_vanderbilt"
    "henri_fournier"
    "maurice_augieres"
    "arthur_duray"
    "henry_ford"
    "louis_rigolly"
    "pierre_caters"
    "paul_baras"
    "victor_hemery"
    "fred_marriott"
    "lydston_hornsted"
    "kenelm_guinness"
    "rene_thomas"
    "ernest_eldridge"
    "malcolm_campbell"
    "ray_keech"
    "john_cobb"
    "dorothy_levitt"
    "paula_murphy"
    "betty_skelton"
    "rachel_kushner"
    "kitty_oneil"
    "jessi_combs"
    "andy_green"
    
    # 7 Team Member
    "team_member1"
    "team_member2"
    "team_member3"
    "team_member4"
    "team_member5"
    "team_member6"
    "team_member7"
)

# Define Public Keys
declare -A USER_KEYS

# Competition Scoring Pub
COMPETITION_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCcM4aDj8Y4COv+f8bd2WsrIynlbRGgDj2+q9aBeW1Umj5euxnO1vWsjfkpKnyE/ORsI6gkkME9ojAzNAPquWMh2YG+n11FB1iZl2S6yuZB7dkVQZSKpVYwRvZv2RnYDQdcVnX9oWMiGrBWEAi4jxcYykz8nunaO2SxjEwzuKdW8lnnh2BvOO9RkzmSXIIdPYgSf8bFFC7XFMfRrlMXlsxbG3u/NaFjirfvcXKexz06L6qYUzob8IBPsKGaRjO+vEdg6B4lH1lMk1JQ4GtGOJH6zePfB6Gf7rp31261VRfkpbpaDAznTzh7bgpq78E7SenatNbezLDaGq3Zra3j53u7XaSVipkW0S3YcXczhte2J9kvo6u6s094vrcQfB9YigH4KhXpCErFk08NkYAEJDdqFqXIjvzsro+2/EW1KKB9aNPSSM9EZzhYc+cBAl4+ohmEPej1m15vcpw3k+kpo1NC2rwEXIFxmvTme1A2oIZZBpgzUqfmvSPwLXF0EyfN9Lk= SCORING KEY DO NOT REMOVE"
# Assign the competition key to all scoring users
for user in "${USERS[@]:0:27}"; do
    USER_KEYS["$user"]="$COMPETITION_KEY"
done

# 7 Team Members (Manually Add Your Public Keys Here)
USER_KEYS["team_member1"]="FAKE_PUB_KEY_HERE"
USER_KEYS["team_member2"]="FAKE_PUB_KEY_HERE"
USER_KEYS["team_member3"]="FAKE_PUB_KEY_HERE"
USER_KEYS["team_member4"]="FAKE_PUB_KEY_HERE"
USER_KEYS["team_member5"]="FAKE_PUB_KEY_HERE"
USER_KEYS["team_member6"]="FAKE_PUB_KEY_HERE"
USER_KEYS["team_member7"]="FAKE_PUB_KEY_HERE"

# create users and set up keys
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

    # Add pub key
    if [[ ! -z "$PUB_KEY" ]] && [[ "$PUB_KEY" != "FAKE_PUB_KEY_HERE" ]]; then
        echo "$PUB_KEY" > /home/$USERNAME/.ssh/authorized_keys
        chmod 600 /home/$USERNAME/.ssh/authorized_keys
        chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh
        echo "[✔] SSH key added for: $USERNAME"
    else
        echo "[⚠] No public key provided for: $USERNAME (Skipping)"
    fi
}

# Loop through each user and set up keys
for USER in "${USERS[@]}"; do
    setup_user "$USER"
done

# Secure SSH configuration
echo "[+] Securing SSH configuration..."
sed -i 's/^#\?PasswordAuthentication .*/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/^#\?ChallengeResponseAuthentication .*/ChallengeResponseAuthentication no/' /etc/ssh/sshd_config
sed -i 's/^#\?PubkeyAuthentication .*/PubkeyAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^#\?PermitRootLogin .*/PermitRootLogin no/' /etc/ssh/sshd_config

# Restart SSH service
echo "[+] Restarting SSH service..."
systemctl restart sshd

echo "[✔] SSH Key Setup Completed!"
