#!/bin/bash

sudo apt update && sudo apt install docker.io docker-compose npm -y

echo "#### Starting Docker Services #####"
sudo systemctl start docker

echo "#### Adding User to Docker Group #####"
sudo usermod -aG docker $USER

echo "#### Cloning Remote Repositories #####"
git clone https://github.com/Talha-Altair/ares-app.git

echo "#### Running NPM install for node Modules #####"
cd ares-app/frontend && npm install
cd ..

echo "#### Running Docker Compose file #####"
sudo docker-compose up -d