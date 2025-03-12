#  Cowrie SSH Honeypot Playbook

##  Objective
Deploy a Honeypot quickly to distract attackers.

##  Step-by-Step Cowrie Setup:

### **Step 1: Install Cowrie**
`git clone https://github.com/cowrie/cowrie.git cd cowrie sudo pip install -r requirements.txt`

### **Step 2: Start Cowrie**
`sudo bin/cowrie start`


## Important Notes:
- **Logs:** `~/cowrie/logs`
- **Restart Cowrie:** `sudo bin/cowrie restart`

## ⚠ Troubleshooting:
- If Cowrie doesn't start, verify dependencies: Python installed correctly?

**END OF PLAYBOOK**

