#!/bin/bash
# Install dependencies
sudo apt update
sudo apt install -y net-tools docker.io nginx

# Copy main script to /usr/local/bin
sudo cp devopsfetch.sh /usr/local/bin/devopsfetch
sudo chmod +x /usr/local/bin/devopsfetch



# Setup systemd service
sudo cp systemd/devopsfetch.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable devopsfetch.service
sudo systemctl start devopsfetch.service


echo "DevOpsFetch has been installed and the service has been started."

