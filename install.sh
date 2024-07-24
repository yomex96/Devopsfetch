#!/bin/bash
# Install dependencies
sudo apt update
sudo apt install -y net-tools docker.io nginx logrotate

# Copy main script to /usr/local/bin
sudo cp devopsfetch.sh /usr/local/bin/devopsfetch
sudo chmod +x /usr/local/bin/devopsfetch

# Setup systemd service
sudo cp devopsfetch.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable devopsfetch.service
sudo systemctl start devopsfetch.service

sudo tee /etc/logrotate.d/devopsfetch > /dev/null <<EOL
/var/log/devopsfetch.log {
    daily
    rotate 7
    compress
    missingok
    notifempty
    create 644 root root
    sharedscripts
    postrotate
        systemctl reload devopsfetch.service > /dev/null 2>/dev/null || true
    endscript
    su root root
}
EOL

# Ensure the log file exists and has the correct permissions
sudo touch /var/log/devopsfetch.log
sudo chown root:root /var/log/devopsfetch.log
sudo chmod 644 /var/log/devopsfetch.log

# Test logrotate configuration
sudo logrotate -d /etc/logrotate.d/devopsfetch

# Force log rotation to test the setup
sudo logrotate -f /etc/logrotate.d/devopsfetch

# Check if the log file and rotated logs are present
ls -l /var/log/devopsfetch*

echo "DevOpsFetch has been installed and the service has been started."

