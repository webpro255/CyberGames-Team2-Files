# CyberGames-Team2-Files

## SSH Setup Script (ssh.sh)
**Purpose:**
Quickly creates secure user accounts for your entire team and immediately locks down SSH by disabling root login, enforcing user permissions, and installing fail2ban.

**Important:**
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





