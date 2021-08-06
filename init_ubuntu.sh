#!/bin/bash

apt-get remove docker docker-engine docker.io containerd runc

apt update -y
apt install apt-transport-https ca-certificates curl gnupg lsb-release -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update -y
apt install docker-ce docker-ce-cli containerd.io -y

curl -s https://api.github.com/repos/docker/compose/releases/latest | grep browser_download_url | grep docker-compose-Linux-x86_64 | cut -d '"' -f 4 | wget -qi -

mv docker-compose-Linux-x86_64 /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

systemctl enable docker
systemctl start docker

echo ""
echo "----------------"
printf "Almost done! Run the following:\n  usermod -aG docker \$USER\nThen re-log in to start using Docker and Docker-Compose.\n"
echo "----------------"
