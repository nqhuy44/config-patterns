#!/bin/bash

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

echo "Starting Linux security hardening..."

# Update the system
echo "[+] Updating system packages..."
apt update && apt upgrade -y

# Disable root login and set SSH security settings
echo "[+] Configuring SSH security..."
sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/^#PermitRootLogin no/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
echo "AllowUsers youruser" >> /etc/ssh/sshd_config
systemctl restart sshd

# Enable firewall and allow necessary services
echo "[+] Configuring firewall..."
ufw allow OpenSSH
ufw enable

# Disable unused network services
echo "[+] Disabling unused services..."
systemctl disable avahi-daemon
systemctl stop avahi-daemon
systemctl disable cups
systemctl stop cups

# Set permissions on critical files
echo "[+] Setting secure file permissions..."
chmod 600 /etc/shadow
chmod 600 /etc/gshadow
chmod 700 /root
chmod 644 /etc/passwd

# Disable USB storage
echo "[+] Disabling USB storage..."
echo "blacklist usb-storage" >> /etc/modprobe.d/blacklist.conf
modprobe -r usb-storage

# Enable automatic security updates
echo "[+] Enabling automatic updates..."
apt install unattended-upgrades -y
dpkg-reconfigure --priority=low unattended-upgrades

# Configure auditing
echo "[+] Configuring auditd..."
apt install auditd audispd-plugins -y
systemctl enable auditd
auditctl -e 1
echo "-w /etc/passwd -p wa -k passwd_changes" >> /etc/audit/rules.d/audit.rules
echo "-w /etc/shadow -p wa -k shadow_changes" >> /etc/audit/rules.d/audit.rules
echo "-w /var/log/auth.log -p wa -k auth_logs" >> /etc/audit/rules.d/audit.rules
service auditd restart

# Disable IPv6 (if not needed)
echo "[+] Disabling IPv6..."
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
sysctl -p

# Remove unnecessary software packages
echo "[+] Removing unnecessary packages..."
apt remove -y telnet rsh-server rsh talk talk-server

# Restart services
echo "[+] Restarting services..."
systemctl restart sshd
ufw reload

echo "Linux security hardening completed."