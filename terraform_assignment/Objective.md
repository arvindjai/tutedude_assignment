#### You are required to deploy a Flask backend and an Express frontend application using AWS and Terraform. Follow the steps below to deploy the applications in different configurations.

# Part 1: Deploy Both Flask and Express on a Single EC2 Instance
### 1. Objective:  Deploy both the Flask backend and the Express frontend on a single EC2 instance using Terraform.
- Provision the EC2 instance with Terraform.
- Configure the instance with:
-- A user data script or a configuration management tool (e.g., Ansible or Cloud-Init) to install dependencies (Python, Node.js).
-- Scripts to start the Flask backend and the Express frontend.
- Ensure both applications are running on different ports (e.g., Flask on port 5000 and Express on port 3000).
### 2. Expected Deliverables:
- Terraform configuration files (main.tf, variables.tf, etc.).
- A working EC2 instance with Flask and Express running and accessible via the instance's public IP.


# Part 2: Deploy Flask and Express on Separate EC2 Instances
### 1. Objective: Deploy the Flask backend and the Express frontend on two separate EC2 instances using Terraform.
###### a. Provision two EC2 instances using Terraform:
- One for the Flask backend.
- One for the Express frontend.
- Configure security groups to:
- Allow communication between the two instances.
- Expose both applications to the internet on their respective ports.
###### b. Configuration:
Use Terraform to define networking resources, such as VPC, subnets, and security groups.
Use user data scripts to automate the installation and startup of both applications.
### 2. Expected Deliverables:
- Terraform configuration files.
- Two working EC2 instances: one running Flask and one running Express.
- Security groups configured to allow proper communication and public access.

# Part 3: Deploy Flask and Express Using Docker and AWS Services
### 1. Objective: Deploy Flask and Express as Docker containers using AWS ECR, ECS, and VPC with Terraform.
#### 2. Steps:
##### ECR:
- Use Terraform to create two Elastic Container Registry (ECR) repositories: one for the Flask backend and one for the Express frontend.
- Build Docker images for both applications and push them to their respective ECR repositories.
##### VPC:
- Use Terraform to create a VPC with subnets, route tables, and security groups.
##### ECS:
- Use Terraform to set up an ECS cluster.
- Create two ECS services:
- One for the Flask backend.
- One for the Express frontend.
- Use ECS Fargate or EC2 launch type to deploy the containers.
##### Load Balancer:
- Use Terraform to provision an Application Load Balancer (ALB).
- Configure ALB listeners to route requests to the appropriate ECS service.
#### 3. Expected Deliverables:
- Terraform configuration files for ECR, ECS, VPC, and ALB setup.
- Docker images pushed to ECR.
- ECS services running and accessible via the ALB.

#### General Requirements
- Ensure that all Terraform configurations follow best practices, including the use of variables.tf and outputs.tf.
- Use Terraform State (e.g., S3 backend) for state management.
- Use terraform plan and terraform apply to validate and deploy infrastructure.
- Document the deployment process in a README.md file.


#### Submission Guidelines -: 
- Attach Screenshots or command along with explanation and submit in doc(google doc or microsoft doc) format and share your github repo link


