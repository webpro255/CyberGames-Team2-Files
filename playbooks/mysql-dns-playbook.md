#  Database (MySQL) and DNS Server Security Playbook

## Objective
Secure MySQL database and DNS server.

## MySQL Setup Instructions:

### **Step 1: Install MySQL Server**
`sudo apt update && sudo apt install mysql-server -y`


### **Step 2: Secure MySQL Immediately**
`sudo mysql_secure_installation`
Follow prompts to secure.

## DNS (BIND9) Setup Instructions:

### **Step 1: Install BIND9**
`sudo apt install bind9 -y`


### **Step 2: Secure DNS Configuration**
`sudo nano /etc/bind/named.conf.options`
Set:
`options { allow-query { localhost; 192.168.t.0/24; }; recursion no; };`


### **Step 3: Restart DNS**
`sudo systemctl restart bind9`


## Troubleshooting:
- MySQL access denied? Check passwords and privileges.
- DNS query failed? Verify DNS config carefully.

**END OF PLAYBOOK**

