#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y python3 python3-pip git

cd /home/ubuntu
git clone https://github.com/Talha-Altair/ares-app.git || true
cd ares-app/backend

sudo apt install python3-venv -y
python3 -m venv flask
source flask/bin/activate
pip install -r requirements.txt || true

nohup python3 app.py > /home/ubuntu/flask.log 2>&1 &