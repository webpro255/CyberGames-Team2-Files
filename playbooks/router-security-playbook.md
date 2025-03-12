#  MikroTik Router Security Playbook

##  Objective
Quickly secure and configure MikroTik Router at competition start.

##  Default Credentials
- Username: `admin`
- Password: *(default blank)*

##  Step-by-Step Instructions:

### **Step 1: Access Router**
- Open browser, enter router IP (usually `172.18.0.1`).
- Log in with default credentials.

### **Step 2: Immediately Change Password**
Go to Terminal:
`set admin password=YourStrongPassword`


### **Step 3: Configure Firewall Rules (Critical!)**
Go to Terminal:
`/ip firewall filter add chain=input protocol=tcp dst-port=22,80,443 action=accept comment="Allow SSH, HTTP, HTTPS" /ip firewall filter add chain=input action=drop comment="Block All Other Traffic"`


### **Step 4: Configure NAT (Network Address Translation)**
`/ip firewall nat add chain=srcnat action=masquerade out-interface=ether1`


### **Step 5: Verify Settings**
`/ip firewall filter print /ip firewall nat print`


### 🚩 **Step 6: Backup Configuration**
/system backup save name=team2-router-backup


## 🔎 Troubleshooting & Common Issues:
- Locked out accidentally? Reset and restart quickly.
- Check firewall rules carefully if network not reachable.

**END OF PLAYBOOK**


