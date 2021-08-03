#!/bin/bash

# Script to Add the Centos Docker Repo, Install Docker and Docker-Compose, and enable/start the Docker service.
# The user will have to run the `usermod -aG docker $USER` by themselves, it won't work for some reason.

dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf update -y --allowerasing --nobest
dnf upgrade -y --allowerasing --nobest

dnf install docker-ce curl wget --allowerasing --nobest -y
curl -s https://api.github.com/repos/docker/compose/releases/latest | grep browser_download_url | grep docker-compose-Linux-x86_64 | cut -d '"' -f 4 | wget -qi -

mv docker-compose-Linux-x86_64 /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

systemctl enable docker
systemctl start docker

echo ""
echo "----------------"
printf "Almost done! Run the following:\n  usermod -aG docker $USER\nThen re-log in to start using Docker and Docker-Compose.\n"
echo "----------------"
