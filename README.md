# 🛠️ MCIT DevOps Project

![GitHub repo size](https://img.shields.io/github/repo-size/ahmed-el-mahdy/MCIT-DevOps-Project)
![GitHub contributors](https://img.shields.io/github/contributors/ahmed-el-mahdy/MCIT-DevOps-Project)
![GitHub stars](https://img.shields.io/github/stars/ahmed-el-mahdy/MCIT-DevOps-Project?style=social)
![GitHub forks](https://img.shields.io/github/forks/ahmed-el-mahdy/MCIT-DevOps-Project?style=social)

---

## 🌟 Project Overview

The **MCIT DevOps Project** aims to streamline the deployment and management of applications using **AWS EKS**, **Jenkins**, and **Terraform**, enabling efficient CI/CD pipelines. This project integrates multiple DevOps tools and practices to build a fully automated pipeline for deploying a three-tier application.

### 🔧 Key Technologies
- 🐳 **Docker** for containerization
- ☸️ **Kubernetes** for container orchestration
- 🏗️ **Terraform** for Infrastructure as Code (IaC)
- 🔧 **Jenkins** for CI/CD pipeline automation

---

## 🛠️ Tools Used

![AWS](https://img.shields.io/badge/AWS-232F3E?style=flat-square&logo=amazonaws&logoColor=white)
![EKS](https://img.shields.io/badge/EKS-232F3E?style=flat-square&logo=amazon-ecs&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=flat-square&logo=kubernetes&logoColor=white)
![Jenkins](https://img.shields.io/badge/Jenkins-D24939?style=flat-square&logo=jenkins&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=flat-square&logo=terraform&logoColor=white)
![Ansible](https://img.shields.io/badge/Ansible-EE0000?style=flat-square&logo=ansible&logoColor=white)
![C#](https://img.shields.io/badge/C%23-239120?style=flat-square&logo=csharp&logoColor=white)
![HCL](https://img.shields.io/badge/HCL-FFFFFF?style=flat-square&logo=hashicorp&logoColor=black)
![CSS](https://img.shields.io/badge/CSS-1572B6?style=flat-square&logo=css3&logoColor=white)
![Angular](https://img.shields.io/badge/Angular-DD0031?style=flat-square&logo=angular&logoColor=white)
![Dotnet SDK](https://img.shields.io/badge/.NET-512BD4?style=flat-square&logo=.net&logoColor=white)
![HTML](https://img.shields.io/badge/HTML-E34F26?style=flat-square&logo=html5&logoColor=white)
![TypeScript](https://img.shields.io/badge/TypeScript-007ACC?style=flat-square&logo=typescript&logoColor=white)

---

## 👥 Collaborators

A special thanks to our collaborators who helped make this project a success:
- [ibrahim-mohamed-zaghloul](https://github.com/ibrahim-mohamed-zaghloul)
- [Michael-Haleem](https://github.com/Michael-Haleem)
- [Eng-Mohamed-Emad](https://github.com/Eng-Mohamed-Emad)
- [zabdeln4](https://github.com/zabdeln4)

---

## 📝 Recent Updates
- 🚀 Environment variables added to Kubernetes deployments for improved configurability.
- 🧪 CI/CD pipeline enhanced with automated testing using Jenkins.
- 🐳 Docker Compose and Kubernetes manifest files updated for Minikube compatibility.

---

## 🚀 Getting Started
1. **Prerequisites**: Ensure you have Docker, Kubernetes, and AWS CLI installed.
2. **Installation**:
   ```bash
   git clone https://github.com/ahmed-el-mahdy/MCIT-DevOps-Project.git
   cd MCIT-DevOps-Project
   docker-compose up
      
### ☸️ Run with Minikube:
Ensure Minikube is installed and running, then apply the Kubernetes manifest files:
      
     kubectl apply -f k8s-manifests/

## 🤖 Ansible Playbooks
This project utilizes Ansible for automating application deployments and configuration management. The playbooks are designed to:
- Install necessary packages.
- Configure application settings.
- Manage service states.

### How to Run Ansible Playbooks

-   Ensure you have Ansible installed and the inventory file set up with your target hosts.
-   
To execute an Ansible playbook, use the following command:
      ```bash
   
        ansible-playbook -i inventory playbook.yml



## 🌱 Terraform
Terraform is used in this project to provision the AWS infrastructure. It allows for Infrastructure as Code (IaC), ensuring reproducibility and version control.

### Resources Provisioned
- **VPC**: Virtual Private Cloud for network isolation.
- **Subnets**: Configured for public and private access.
- **EC2 Instances**: For running applications and services.
- **RDS**: MySQL database instance for data storage.

###  Make sure you have Terraform installed and configured with your AWS credentials.

### How to Deploy with Terraform
1. Initialize Terraform:
      ```bash
      terraform init
2. Plan the deployment:
      ```bash
      terraform plan
1. Apply the changes:
      ```bash
      terraform apply




### 🧰 CI/CD Pipeline
The CI/CD pipeline, managed using **Jenkins**, automates the process from code commits to deployment. It includes:

- 🧹 **Code linting**
- 🧪 **Automated testing**
- 🏗️ **Container building**
- 🚀 **Deployment to a Kubernetes cluster**

### ☁️ Infrastructure as Code (IaC)
Using **Terraform**, this project provisions the necessary AWS infrastructure:

- 🌐 **VPC**
- 🖧 **Subnets**
- 💻 **EC2 Instances**
- 🗄️ **EKS Cluster**

Ensure you have Terraform installed and configured to interact with AWS.

### 📝 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

This version enhances readability with icons and proper markdown formatting for code sections. Let me know if further improvements are needed!

