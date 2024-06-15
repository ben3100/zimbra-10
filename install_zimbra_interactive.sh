#!/bin/bash

# Prompt for FQDN
read -p "Enter the full domain name (FQDN) for Zimbra (e.g., mail.yourdomain.com): " FQDN

# Prompt for timezone
read -p "Enter your timezone (e.g., Europe/Paris): " TIMEZONE

# Variables
ZIMBRA_PACKAGE="zcs-NETWORK-10.0.0_GA_4518.UBUNTU20_64.20230301065514.tgz"
ZIMBRA_URL="https://files.zimbra.com/downloads/10.0.0_GA/${ZIMBRA_PACKAGE}"

# Update the system
echo "Updating the system..."
apt update && apt upgrade -y

# Set hostname
echo "Setting hostname to $FQDN..."
hostnamectl set-hostname $FQDN

# Modify /etc/hosts
echo "Configuring /etc/hosts..."
cat <<EOL > /etc/hosts
127.0.0.1 localhost
127.0.0.1 $FQDN mail
EOL

# Configure resolv.conf
echo "Configuring /etc/resolv.conf..."
cat <<EOL > /etc/resolv.conf
nameserver 8.8.8.8
nameserver 8.8.4.4
EOL

# Disable systemd-resolved
echo "Disabling systemd-resolved..."
systemctl disable systemd-resolved
systemctl stop systemd-resolved

# Install required dependencies
echo "Installing required dependencies..."
apt install -y net-tools sudo wget perl unzip libaio1 libstdc++6 perl-modules libperl5.30 sysstat sqlite3 dnsmasq-base

# Configure dnsmasq
echo "Configuring dnsmasq..."
cat <<EOL > /etc/dnsmasq.conf
listen-address=127.0.0.1
bind-interfaces
address=/$FQDN/127.0.0.1
EOL

# Restart dnsmasq
echo "Restarting dnsmasq..."
systemctl restart dnsmasq

# Set timezone
echo "Setting timezone to $TIMEZONE..."
timedatectl set-timezone $TIMEZONE

# Download Zimbra
echo "Downloading Zimbra..."
cd /tmp
wget $ZIMBRA_URL
tar xvf $ZIMBRA_PACKAGE
cd ${ZIMBRA_PACKAGE%.tgz}

# Install Zimbra with platform override
echo "Starting Zimbra installation..."
./install.sh --platform-override

# Run Zimbra setup script
echo "Running Zimbra setup script..."
/opt/zimbra/libexec/zmsetup.pl

# Restart Zimbra services
echo "Restarting Zimbra services..."
su - zimbra -c 'zmcontrol restart'

# Configure firewall
echo "Configuring firewall..."
ufw allow 22/tcp   # SSH
ufw allow 25/tcp   # SMTP
ufw allow 80/tcp   # HTTP
ufw allow 443/tcp  # HTTPS
ufw allow 465/tcp  # SMTPS
ufw allow 587/tcp  # Submission
ufw allow 993/tcp  # IMAPS
ufw allow 995/tcp  # POP3S
ufw allow 7071/tcp # Admin Console
ufw allow 8080/tcp # HTTP Alternate
ufw allow 8443/tcp # HTTPS Alternate
ufw enable

# Display completion message
echo "Zimbra installation and configuration are complete. Access the admin interface via https://$FQDN:7071"
