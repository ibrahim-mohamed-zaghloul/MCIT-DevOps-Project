# 🌐 MCIT DevOps Project - Automated Application Deployment 🚀

![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white) ![Jenkins](https://img.shields.io/badge/Jenkins-%232C5263.svg?style=for-the-badge&logo=jenkins&logoColor=white) ![Kubernetes](https://img.shields.io/badge/Kubernetes-%23326CE5.svg?style=for-the-badge&logo=Kubernetes&logoColor=white) ![Terraform](https://img.shields.io/badge/Terraform-%23623CE4.svg?style=for-the-badge&logo=terraform&logoColor=white) ![Ansible](https://img.shields.io/badge/Ansible-%23E5E5E5.svg?style=for-the-badge&logo=ansible&logoColor=%23403E3E) ![Docker](https://img.shields.io/badge/Docker-%232C4CDA.svg?style=for-the-badge&logo=docker&logoColor=white) ![C#](https://img.shields.io/badge/C%23-%23239120.svg?style=for-the-badge&logo=csharp&logoColor=white) ![Angular](https://img.shields.io/badge/Angular-%E03A3E.svg?style=for-the-badge&logo=angular&logoColor=white) ![.NET](https://img.shields.io/badge/.NET-%23007ACC.svg?style=for-the-badge&logo=.net&logoColor=white) ![Unit Test](https://img.shields.io/badge/Unit%20Test-%23D32F2F.svg?style=for-the-badge&logoColor=white) ![Git](https://img.shields.io/badge/Git-%23F1502F.svg?style=for-the-badge&logo=git&logoColor=white) ![GitHub](https://img.shields.io/badge/GitHub-%23181717.svg?style=for-the-badge&logo=github&logoColor=white) ![Build Automation](https://img.shields.io/badge/Build%20Automation-%23E4B400.svg?style=for-the-badge&logoColor=white) ![CI/CD](https://img.shields.io/badge/CI/CD-%2300BFFF.svg?style=for-the-badge&logo=gitlab&logoColor=white)



Welcome to the **MCIT DevOps Project**! This project demonstrates the complete automated deployment of a **3-tier web application** using a variety of DevOps tools and practices. The application is deployed on **AWS EKS (Elastic Kubernetes Service)** via a **CI/CD pipeline** orchestrated using **Jenkins** and **Terraform** for infrastructure provisioning.

---

## Table of Contents 📑

- [Project Overview](#project-overview)
- [Application Architecture](#application-architecture)
- [Kubernetes Manifests](#kubernetes-manifests)
- [CI/CD Pipeline](#ci-cd-pipeline)
- [AWS EKS & Terraform](#aws-eks--terraform)
- [How to Deploy](#how-to-deploy)
- [Contributing](#contributing)
- [License](#license)

---

## Project Overview 🌟

This **3-tier web application** consists of a **frontend UI**, a **backend API**, and a **SQL Server database**. The main idea behind the project is to demonstrate a fully automated DevOps pipeline that deploys a production-ready application on **AWS EKS**.

The key objectives of the project include:

- **Automating infrastructure provisioning** using **Terraform**.
- **Building a CI/CD pipeline** with **Jenkins** to deploy the application on **AWS EKS**.
- **Containerizing the application** using **Docker**.
- **Orchestrating the deployment** using **Kubernetes**.
- **Managing configurations** via **ConfigMaps** and **Secrets**.

This project is a hands-on example of applying DevOps principles to streamline and automate the deployment process, ensuring scalability and high availability.

---

## Application Architecture 🏗️

The application follows a **3-tier architecture** with the following components:

1. **Frontend**: 
   - A React-based web interface that communicates with the backend API.
   - Containerized using Docker.

2. **Backend**: 
   - A Node.js-based API that interacts with the frontend and database.
   - Exposes REST endpoints for data operations.
   - Also containerized using Docker.

3. **SQL Server**:
   - Manages the persistent data layer for the application.
   - Runs in a separate Kubernetes pod with persistent volume storage.

### Application Structure 📂

| Folder/File               | Description                                                                 |
|---------------------------|-----------------------------------------------------------------------------|
| **`frontend/`**            | Contains the React code for the UI. Includes Dockerfile for containerization.|
| **`backend/`**             | Contains the Node.js code for the API. Includes Dockerfile and tests.        |
| **`k8s-manifets/`**        | Kubernetes manifests for deploying the frontend, backend, and database pods. |
| **`Jenkinsfile`**          | Jenkins pipeline definition for automating the deployment process.           |
| **`terraform/`**           | Terraform scripts to provision infrastructure on AWS (EKS, VPC, etc.).       |

---

## Kubernetes Manifests 🛠️

The **Kubernetes manifests** located in the `k8s-manifets/` folder define the deployment and management of the application's services on the Kubernetes cluster. These include:

| File Name                     | Description                                                                 |
|-------------------------------|-----------------------------------------------------------------------------|
| **`frontend-deployment.yaml`** | Deploys the frontend pod with a load balancer service to expose it externally. |
| **`backend-deployment.yaml`**  | Deploys the backend API pod. Configures scaling and resource limits.          |
| **`sqlserver-deployment.yaml`**| Deploys the SQL Server pod, defines persistent storage via PV and PVC.        |
| **`ingress.yaml`**             | Manages external access to the frontend and backend services via HTTP/HTTPS. |
| **`configmap.yaml`**           | Stores configuration data such as environment variables for the app.         |
| **`secrets.yaml`**             | Stores sensitive data like database credentials securely.                    |
| **`persistent-volume.yaml`**   | Describes the physical storage available to the SQL Server pod.              |
| **`persistent-volume-claim.yaml`** | Requests storage resources for the SQL Server pod.                    |

These manifests ensure the application is scalable, secure, and highly available within the Kubernetes environment.

---

## CI/CD Pipeline 🔄

The CI/CD pipeline is defined in the **Jenkinsfile** and automates the following steps:

1. **Source Code Checkout**: Pulls the latest code from the repository.
2. **Build & Test**:
   - Builds Docker images for the frontend, backend, and database.
   - Runs automated tests on the backend API.
3. **Push to Docker Hub**: Uploads the Docker images to the Docker registry.
4. **Deploy to Kubernetes**:
   - Uses **kubectl** to apply the Kubernetes manifests and deploy the application to **AWS EKS**.

This automated pipeline ensures fast, reliable, and consistent deployments.

---

## AWS EKS & Terraform 🌍

We use **Terraform** to automate the provisioning of the AWS infrastructure. This includes:

- **Amazon EKS Cluster**: A fully managed Kubernetes service to run the application.
- **VPC and Subnets**: Configured for high availability and scalability.
- **IAM Roles & Security Groups**: Ensures secure access to the EKS cluster and other AWS resources.

The Terraform files located in the `terraform/` directory automate the entire infrastructure setup. Once the infrastructure is provisioned, the application is automatically deployed to the EKS cluster through the Jenkins pipeline.

---

## How to Deploy 🧑‍💻 📝

To deploy this application using the Jenkins pipeline and Terraform, follow the steps below:

### Prerequisites:
1. **AWS account** with permissions to create resources (EKS, VPC, IAM, etc.).
2. **Jenkins** installed and configured.
3. **Docker** installed to build and push images.
4. **kubectl** installed to manage the Kubernetes cluster.

### Steps:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/ciscosky/MCIT-DevOps-Project.git

2. **Setup Terraform**:
   Navigate to the `terraform/` directory and initialize Terraform:
   ```bash
   cd terraform
   terraform init
   terraform apply
3. **Configure Jenkins**:
- 🛡️ Add your AWS credentials** and Docker Hub credentials to Jenkins.
- 🔄 Setup Jenkins** to pull this repository and run the Jenkinsfile.

4. **Run the Jenkins Pipeline**:
 -🎬 Trigger the pipeline. Jenkins will manage the CI/CD process, automatically building, testing, and deploying the application to the EKS cluster. 

5. **Run the Jenkins Pipeline**:
- 🌐 Once triggered, Jenkins will handle the CI/CD process, automatically building, testing, and deploying the application to the EKS cluster.

## 🎉 Happy Deploying!
### 📋 Instructions for Use:

1. **Copy and Paste**: Copy the above Markdown into your `README.md` file.
2. **Check Formatting**: Ensure the formatting remains intact, especially for the code blocks and icons. 
3. **Preview**: Use the preview feature on GitHub to see the final look.

---

### 💬 Need Help?
If you have any other requests or need further customization, feel free to reach out!

