# Monitoring and Incident Response Playbook

## Objective
Quickly detect threats and monitor server logs.

## Setup Snort IDS:
`sudo apt install snort -y`


## Monitoring Essential Logs:
Open a terminal, run:
`tail -f /var/log/syslog /var/log/auth.log /var/log/apache2/access.log`


### **What to Look For:**
- Failed logins
- Unusual IP addresses
- Errors or suspicious HTTP requests

### **Report Suspicious Activity Immediately in Discord.**

**END OF PLAYBOOK**

