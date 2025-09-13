#!/bin/bash

sudo apt-get update -y
sudo apt-get install npm git -y

cd /home/ubuntu
git clone https://github.com/arvindjai/flask-express.git || true
cd ares-app/frontend

echo "BACKEND_URL=http://${backend_ip}:8000/api" > .env

npm install
nohup BACKEND_URL=http://${backend_ip}:8000/api npm start > /home/ubuntu/frontend.log 2>&1 &
