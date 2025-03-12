
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

**END OF PLAYBOOK**


