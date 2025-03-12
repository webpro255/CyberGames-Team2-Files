# NCAE Cyber Games 2025 - Blue Team 2 Repository

This repository contains the official scripts and playbooks used by our team during the NCAE Cyber Games. These scripts will help us quickly secure and configure our network and servers.

---

## Important: Read Before Executing Any Script

**Always carefully review each script before executing.**  
Certain scripts require manual changes (such as usernames, passwords, and IP addresses). Instructions for required edits are clearly marked inside each script.

**Important guidelines before running any script:**

- Verify usernames and passwords carefully.
- Double-check IP addresses and network configurations.
- Run each script **only on its designated server**.  
- Check the **"When and Where to Use"** instructions clearly stated below before executing each script.

---

## Quick Links to Each Script and Playbook

- [SSH Setup Script (`ssh_setup.sh`)](#ssh-setup-script-ssh_setupsh)
- [Firewall Setup Script (`firewall.sh`)](#firewall-setup-script-firewallsh)
- [DNS Server Setup Script (`dns_setup.sh`)](#dns-server-script-dns_setupsh)
- [Apache Web SSL Setup Script (`apache_ssl.sh`)](#apache-ssl-setup-script-apache_sslsh)
- [FTP Server Setup Script (`ftp_setup.sh`)](#ftp-server-setup-script-ftp_setupsh)
- [Cowrie Honeypot Setup Script (`cowrie_honeypot.sh`)](#cowrie-honeypot-setup-script-cowrie_honeypotsh)
- [MySQL Secure Setup Script (`mysql_secure.sh`)](#mysql-secure-setup-script-mysql_securesh)

---

## 🚩 Execution Instructions (Common for All Scripts):

**Make each script executable before running:**
``chmod +x script_name.sh``

**Run each script with sudo privileges:**
``sudo ./script_name.sh``

## 🚩 Review script-specific documentation carefully before executing.

---


## SSH Setup Script (ssh.sh)
**Purpose:**
Quickly creates secure user accounts for your entire team and immediately locks down SSH by disabling root login, enforcing user permissions, and installing fail2ban.

🚩 **Important:**
You must edit the usernames and passwords in the script (`ssh_setup.sh`) before executing it.
Example section you must edit:
- ["webpro"]="NewStrongPassword1"
- ["user2"]="NewStrongPassword2"

Replace "webpro" and "user2" with actual usernames and set strong, unique passwords for each team member.

**How to Execute (ssh_setup.sh):**
Set permissions (make executable):
`chmod +x ssh_setup.sh`
**Run as root (required):**
`sudo ./ssh_setup.sh`

After script runs:
- Users will be created and passwords set.
- Root login via SSH will be disabled for security.
- fail2ban is installed and running.

---

## Firewall Setup Script (firewall.sh)

**Purpose:**
Sets up a basic firewall on all Linux servers to protect against unauthorized access by allowing only essential services like SSH, HTTP, and HTTPS.

Important:
- This script is for Linux servers only (e.g., Web, Database, DNS, FTP servers).
- Do not run this script on the MikroTik router.

Services Allowed (by default):
- SSH (port 22)
- HTTP (port 80)
- HTTPS (port 443)

**Execute (`firewall.sh`):**
Set permissions (make executable):

After script runs:
- Firewall (ufw) will be enabled.
- Default rules applied (deny all incoming, allow essential services).
- Verify rules using:

`sudo ufw status verbose`

---

## DNS Server Script (dns_setup.sh)

**Purpose:**
Installs and securely configures a DNS server (BIND9). This script should only be run on the DNS Server (typically designated as something like 192.168.t.8 in the competition setup).
What it Does:

- Installs BIND9 DNS server software.
- Restricts DNS queries to your internal network only (192.168.0.0/24).
- Disables DNS recursion and zone transfers (enhances security).

**When to Use:**
Only once, immediately after DNS server setup at the start of the competition.
Do not run on other servers.

**Execution Instructions:**
- `chmod +x dns_setup.sh`
- `sudo ./dns_setup.sh`

**After running**
Your DNS service is securely running and protected against external and unauthorized queries.

---

## Apache SSL Setup Script (`apache_ssl.sh`)

**Purpose:**
Installs Apache web server, enables SSL, and generates a Certificate Signing Request (CSR) to obtain an official SSL certificate from the provided NCAE Cyber Games CA server.

**When and Where to Use:**
- Only use on your dedicated Web Server machine (e.g., 192.168.t.5).
- Run once at competition start after initial server configuration and before scoring checks.

**After running:**
- Apache is installed with SSL enabled.
- CSR (team.csr) is generated—upload this immediately to the CA server provided by the competition.
- Manually complete SSL configuration once you receive your certificate.

**Final Quick Checklist After Running `apache_ssl.sh`:**
- Apache installed, running, and enabled
- SSL module enabled
- CSR generated (team.csr) and submitted to CA server
- Certificate (team.crt) received and configured in Apache manually afterward
- SSL secured site accessible on HTTPS port 443

---

## FTP Server Setup Script (`ftp_setup.sh`)
**Purpose:**
Installs and securely configures the FTP server software (vsftpd) quickly, disabling anonymous access and securely restricting local users to their home directories.

**When and Where to Use:**
- Only run on your dedicated FTP server (often the Web or separate FTP server).
- Execute once, immediately after initial server setup at the start of competition.

**Execution Instructions:**
- `chmod +x ftp_setup.sh`
- `sudo ./ftp_setup.sh`

**Security Settings Configured by This Script:**
- Disables anonymous FTP login (`anonymous_enable=NO`)
- Enables secure local-user login with write permissions
- Restricts users securely (`chroot_local_user=YES`)

---

## Cowrie Honeypot Setup Script (`cowrie_honeypot.sh`)
**Purpose:**
The Cowrie honeypot is designed to distract and mislead attackers (Red Team). It imitates an SSH server to attract malicious activity, capturing attacker interactions and logging attempted usernames, passwords, and commands for later analysis.

**When and Where to Use:**
- Where: Run ONLY on a dedicated, isolated honeypot server (e.g., an isolated VM on external subnet, such as 172.18.13.100).
- When: Immediately at the beginning of the competition, after basic networking setup and before opening external firewall rules on the MikroTik router.

**How to Run the Honeypot Script:**
Make the script executable:
**Execution Instructions:**
- `chmod +x cowrie_honeypot.sh`
- `sudo ./cowrie_honeypot.sh`

**What this script does:**
- Installs necessary dependencies (python3, pip, git, etc.).
- Clones the latest Cowrie repository.
- Sets up a virtual environment.
- Installs Cowrie's Python dependencies.
- Starts Cowrie honeypot service.

**Post-installation Checks:**
Verify Cowrie honeypot is running correctly:
- `pgrep -f "twistd -n cowrie"`

**Cowrie logs (important for monitoring attacker activity):**
- `~/cowrie/var/log/cowrie/cowrie.log`

**Restart or manage Cowrie service manually (if needed):**
cd ~/cowrie
sudo bin/cowrie restart
sudo bin/cowrie stop
sudo bin/cowrie start

**MikroTik Router Firewall Rules to Forward Attackers to Honeypot:**
Make sure the MikroTik router is configured to forward traffic on common attacker ports directly to the honeypot IP (172.18.13.100) or Ubuntu server:
`/ip firewall nat add chain=dstnat protocol=tcp dst-port=22 action=dst-nat to-addresses=172.18.13.100`

**Important Security Note:**
- Do NOT run this script on your actual production servers (Web, DNS, FTP, DB).
- The honeypot server must remain isolated from your real internal network.

**Quick Final Checklist after running cowrie_honeypot.sh:**
- Cowrie installed successfully.
- Honeypot running and operational.
- MikroTik NAT rules forwarding SSH attacks (port 22) to honeypot IP.
- Logs actively being monitored for attacker activities.

---

## MySQL Secure Setup Script (mysql_secure.sh)
**Purpose:**
This script securely installs and configures the MySQL Database Server using industry-standard best practices, removing insecure defaults, disabling remote root logins, and hardening overall database security.

**When and Where to Use:**
- Where: Run ONLY on your dedicated MySQL Database Server (e.g., 192.168.t.12) or database server.
- When: Execute immediately after server setup and networking configuration at the competition start.

**What this script does:**
- Installs the latest MySQL Server on Ubuntu.
- Runs the built-in interactive tool mysql_secure_installation that:
- Sets a secure MySQL root password.
- Removes anonymous MySQL users.
- Disallows root MySQL login from remote hosts.
- Deletes the default/test databases.
- Reloads MySQL privilege tables to apply changes immediately.

**How to Execute the Script:**
**Execution Instructions:**
- `chmod +x mysql_secure.sh`
- `sudo ./mysql_secure.sh`

**Follow the interactive prompts carefully, answering securely and clearly:**
- Set a strong root password.
- Answer 'YES' to removing anonymous users, disabling remote root login, and deleting test databases.

**After Script Execution Checklist:**
- MySQL Server installed and running.
- Root password set securely.
- Remote root access disabled.
- Anonymous MySQL users removed.
- Test databases removed.
- MySQL privileges reloaded.

**Check MySQL service status quickly:**
`sudo systemctl status mysql`

**To log in locally to verify MySQL functionality:**
`sudo mysql -u root -p`

**Troubleshooting Common Issues:**
- Forgot root MySQL password?
Reset using:
`sudo mysqladmin -u root password "YourNewSecurePassword"`

**Unable to connect remotely as root:**
This is by design for security purposes. Connect via secure SSH or local access.

---



