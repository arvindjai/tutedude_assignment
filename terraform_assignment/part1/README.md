# Deploy Flask and Express on a Single EC2 Instance using Terraform

## 📌 Problem Statement
The objective is to **deploy both a Flask backend and an Express frontend on a single AWS EC2 instance** using Terraform.  

- **Flask** runs on port `5000`.  
- **Express** runs on port `3000`.  
- Both applications should be accessible via the EC2 instance's **public IP**.  

---

## 🚀 Deliverables
1. Terraform configuration files (`main.tf`, `variables.tf`, `outputs.tf`, etc.).  
2. EC2 instance provisioned on AWS.  
3. Flask backend and Express frontend running on their respective ports.  

---

## 🛠️ Prerequisites
Make sure you have the following installed and configured:

- [Terraform](https://developer.hashicorp.com/terraform/downloads) (v1.3+ recommended)  
- [AWS CLI](https://docs.aws.amazon.com/cli/) configured with valid credentials (`aws configure`)  
- An active AWS account with permissions to create EC2, VPC, and related resources  
- Key Pair created in AWS (to SSH into the instance if needed)  

---

## 📂 Project Structure
.
├── main.tf
├── variables.tf
├── outputs.tf
├── user_data.sh # Script to install dependencies and run Flask + Express
└── README.md

---

## ⚙️ How It Works
1. **Terraform** provisions:
   - A VPC, Subnet, Internet Gateway, and Security Group.  
   - An EC2 instance with a user data script.  

2. **User Data Script** installs:
   - Python and dependencies for Flask.  
   - Node.js and dependencies for Express.  
   - Starts Flask on port `5000` and Express on port `3000`.  

3. **Security Group** opens ports:
   - `22` → SSH  
   - `5000` → Flask backend  
   - `3000` → Express frontend  

---

## ▶️ Steps to Execute

### 1. Clone Repository
```bash
git clone https://github.com/arvindjai/flask-express.git
cd flask-express
```
### 2. Initialize Terraform
```bash
terraform init
```
### 3. Validate Configuration
```bash
terraform validate
```
### 4. Plan Infrastructure
```bash
terraform plan -out=tfplan
```
### 5. Apply Changes
```bash
terraform apply "tfplan"
Terraform will output the public IP address of the EC2 instance.
```


## 📝 User Data Script (user_data.sh)

Below script installs Python, Flask, Node.js, and Express, then runs both applications:
```bash
#!/bin/bash
# Update system packages
sudo apt-get update -y

# Install Python and pip
sudo apt-get install -y python3 python3-pip

# Install Flask
pip3 install flask

# Create Flask app
cat <<EOL > /home/ubuntu/app.py
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello from Flask running on port 5000!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
EOL

# Run Flask app in background
nohup python3 /home/ubuntu/app.py > flask.log 2>&1 &

# Install Node.js and npm
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

# Create Express app
mkdir /home/ubuntu/express-app
cd /home/ubuntu/express-app
npm init -y
npm install express

cat <<EOL > /home/ubuntu/express-app/app.js
const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('Hello from Express running on port 3000!');
});

app.listen(port, '0.0.0.0', () => {
  console.log(\`Express server running at http://0.0.0.0:\${port}\`);
});
EOL


# Run Express app in background
nohup node /home/ubuntu/express-app/app.js > express.log 2>&1 &
```

### 🔍 Verification
**Flask (Backend)**
Open your browser:
http://<EC2-Public-IP>:5000
You should see the Flask app response.

**Express (Frontend)**
Open your browser:
http://<EC2-Public-IP>:3000
You should see the Express app response.

### 🧹 Cleanup
To destroy all created resources:
```bash
terraform destroy
```

✅ Expected Outcome
- A single EC2 instance running Flask on port 5000 and Express on port 3000.
- Applications accessible using the instance’s public IP address.




