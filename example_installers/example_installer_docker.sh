#!/bin/bash
#
# Written by Franklin Moraes.
# It is used to install Docker.

sudo apt-get update -y
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(. /etc/os-release; echo "$UBUNTU_CODENAME") stable"
sudo apt-get update -y
sudo apt-cache policy docker-ce
sudo apt-get -y install docker-ce docker-compose
sudo usermod -aG docker $USER
docker --version
