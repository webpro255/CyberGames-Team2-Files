
# SSH Security Playbook (All Servers)

## Objective
Secure SSH access on all Linux servers quickly.

## Default SSH Info:
- Port: `22`
- Default Root login: enabled (must disable)

## Step-by-Step Instructions:

### **Step 1: Open SSH configuration file**
`sudo nano /etc/ssh/sshd_config`


### **Step 2: Secure SSH Settings**
Modify lines exactly as below:
`PermitRootLogin no PasswordAuthentication yes`

Save file (`Ctrl+O`, then `Ctrl+X` to exit).

### **Step 3: Install fail2ban (Automated Protection)**
`sudo apt update sudo apt install fail2ban -y sudo systemctl enable --now fail2ban`


### **Step 4: Restart SSH Service**
`sudo systemctl restart sshd`


## 🔎 Troubleshooting:
- SSH connection refused: check firewall/router.
- Can't log in after changes? Verify the config carefully or restart SSH.


---

## Tips and tricks

# SSH Security and Hardening Playbook

## Objective

Secure SSH access quickly and effectively on all Linux servers, ensuring only authorized users gain access, while also confusing attackers (Red Team) with decoy user accounts.

## Default SSH Information
- Port: `22`
- Default Root login: enabled (Must be disabled)

## Step-by-Step SSH Security Setup

### Step 1: Create Authorized User Accounts

Replace the usernames/passwords below with real team member info:

```bash
sudo useradd -m -s /bin/bash -G sudo your_username
sudo passwd your_username
```

Repeat for each legitimate team member.

### Step 2: Add Fake SSH Users (Red Team Distraction)

Create decoy users to mislead attackers:

```bash
sudo useradd -m -s /usr/sbin/nologin admin
sudo useradd -m -s /usr/sbin/nologin support
sudo useradd -m -s /usr/sbin/nologin ftpuser
```

Set random passwords for fake users (attackers will waste time):

```bash
echo "admin:FakePass123" | sudo chpasswd
echo "support:FakePass456" | sudo chpasswd
echo "ftpuser:FakePass789" | sudo chpasswd
```

### Step 3: Secure the SSH Configuration

Edit the SSH configuration file:

```bash
sudo nano /etc/ssh/sshd_config
```

Ensure the following settings are set exactly as shown:

```
PermitRootLogin no
PasswordAuthentication yes
AllowUsers your_real_users_here
```

Example:

```
AllowUsers alice bob charlie
```

Save and exit (`Ctrl+O`, then `Ctrl+X`).

### Step 4: Restart SSH Service

Apply the configuration immediately:

```bash
sudo systemctl restart sshd
```

## Step 5: Install Fail2ban for Intrusion Prevention

```bash
sudo apt update
sudo apt install fail2ban -y
sudo systemctl enable --now fail2ban
```

## Tips & Tricks

- **Fake Users:**
  - Create multiple fake users with believable usernames.
  - Do not grant shell access to these fake users (`/usr/sbin/nologin`).
  - Attackers waste time trying to brute-force these accounts, distracting them from real ones.

- **SSH Port Change (Optional):**
  - Change default SSH port from `22` to another port (`2222`, `2200`) to reduce automated scanning.
  - Edit `/etc/ssh/sshd_config` and change:
  ```
  #Port 22
  Port 2222
  ```
  - Restart SSH service afterward.

## Troubleshooting

- **Locked Out?**
  - Restore SSH config backup quickly:
    ```bash
    sudo cp /etc/ssh/sshd_config.bak /etc/ssh/sshd_config
    sudo systemctl restart sshd
    ```

- **SSH Service Issues:**
  - Quickly check SSH service status:
    ```bash
    sudo systemctl status sshd
    ```




**END OF PLAYBOOK**




