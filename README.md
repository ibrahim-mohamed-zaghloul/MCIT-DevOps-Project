# 🛠️ MCIT DevOps Project

![GitHub repo size](https://img.shields.io/github/repo-size/ahmed-el-mahdy/MCIT-DevOps-Project)
![GitHub contributors](https://img.shields.io/github/contributors/ahmed-el-mahdy/MCIT-DevOps-Project)
![GitHub stars](https://img.shields.io/github/stars/ahmed-el-mahdy/MCIT-DevOps-Project?style=social)
![GitHub forks](https://img.shields.io/github/forks/ahmed-el-mahdy/MCIT-DevOps-Project?style=social)

## 🛠️ Tools Used
![AWS](https://img.shields.io/badge/AWS-232F3E?style=flat-square&logo=amazonaws&logoColor=white)
![EKS](https://img.shields.io/badge/EKS-232F3E?style=flat-square&logo=amazon-ecs&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=flat-square&logo=kubernetes&logoColor=white)
![Jenkins](https://img.shields.io/badge/Jenkins-D24939?style=flat-square&logo=jenkins&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=flat-square&logo=terraform&logoColor=white)
![Ansible](https://img.shields.io/badge/Ansible-EE0000?style=flat-square&logo=ansible&logoColor=white)


This project aims to streamline deployment and management of applications using AWS EKS, Jenkins, and Terraform, enabling efficient CI/CD pipelines.


## 👥 Collaborators

- [ibrahim-mohamed-zaghloul](https://github.com/ibrahim-mohamed-zaghloul)
- [Michael-Haleem](https://github.com/Michael-Haleem)
- [Eng-Mohamed-Emad](https://github.com/Eng-Mohamed-Emad)

## 🚀 Project Overview

This project integrates multiple DevOps tools and practices to build a fully automated pipeline for deploying a three-tier application. It leverages:
- 🐳 **Docker** for containerization
- ☸️ **Kubernetes** for container orchestration
- 🏗️ **Terraform** for infrastructure as code (IaC)
- 🔧 **Jenkins** for CI/CD pipeline automation

### 📝 Recent Updates
- Environment variables added to Kubernetes deployments.
- CI/CD pipeline enhanced with automated testing using Jenkins.
- Docker Compose and Kubernetes manifest files updated for Minikube compatibility.

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
- 🗄️ **RDS (MySQL) Database**

Ensure you have Terraform installed and configured to interact with AWS.

### 📝 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

This version enhances readability with icons and proper markdown formatting for code sections. Let me know if further improvements are needed!

