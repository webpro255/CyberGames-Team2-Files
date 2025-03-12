# Web (Apache) and FTP Server Security Playbook

## Objective
Set up Web Server (Apache) with SSL certificate and secure FTP.

## Web Server SSL Instructions:

### **Step 1: Install Apache**
`sudo apt update sudo apt install apache2 openssl -y sudo systemctl enable apache2`

### **Step 2: Enable SSL module**
`sudo a2enmod ssl sudo systemctl restart apache2`


### **Step 3: Generate CSR for CA**
Run:
`openssl req -newkey rsa:2048 -nodes -keyout team.key -out team.csr`
- **Upload `team2.csr` to CA server provided by competition.**
- **Download certificate (`team2.crt`).**

### **Step 4: Configure SSL in Apache**
`sudo nano /etc/apache2/sites-available/default-ssl.conf`
Edit lines to:
`SSLCertificateFile /path/to/team2.crt SSLCertificateKeyFile /path/to/team2.key`
Enable the site:
`sudo a2ensite default-ssl sudo systemctl reload apache2`


## FTP Server Instructions:

### **Step 1: Install FTP Server (vsftpd)**
`sudo apt install vsftpd -y`


### **Step 2: Secure FTP Configuration**
Edit vsftpd config:
`sudo nano /etc/vsftpd.conf`
Add/Update these lines:
`anonymous_enable=NO write_enable=YES local_enable=YES chroot_local_user=YES allow_writeable_chroot=YES`

### **Step 3: Restart FTP Server**
`sudo systemctl restart vsftpd`


## Troubleshooting:
- Apache SSL not working? Check paths to `.crt` and `.key` files.
- FTP Login issues? Double-check vsftpd config file.

**END OF PLAYBOOK**


