#!/bin/bash
#
# Written by Franklin Moraes.
# It is used to install OpenSSH-Server and modify its default port.

echo "Installing OpenSSH Server."
sudo apt install openssh-server -y
echo "Modifying the default port of the SSH server to 1000."
cd /etc/ssh/
sudo echo "$(sed 's/Port 22/Port 1000/g' /etc/ssh/sshd_config)" > /etc/ssh/sshd_config
echo "Successfully modified! The new access via SSH will be through port 1000"
