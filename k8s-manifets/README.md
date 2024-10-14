# 🚀 MCIT DevOps Project - Kubernetes Manifests 📦

![Kubernetes](https://img.shields.io/badge/Kubernetes-%23326CE5.svg?style=for-the-badge&logo=Kubernetes&logoColor=white) ![DevOps](https://img.shields.io/badge/DevOps-%2300AFD7.svg?style=for-the-badge&logo=devops&logoColor=white) ![Minikube](https://img.shields.io/badge/Minikube-%2300AFD7.svg?style=for-the-badge&logo=minikube&logoColor=white)

Welcome to the Kubernetes manifests section of the **MCIT DevOps Project**! This repository contains all the necessary manifest files to deploy and run the project on a **Minikube** cluster.

## Table of Contents 📑
- [Overview](#overview)
- [Kubernetes Manifests](#kubernetes-manifests)
- [Files Overview](#files-overview)
- [How to Deploy](#how-to-deploy)
- [Contributing](#contributing)
- [License](#license)

---

## Overview 🌐

This project demonstrates a fully automated deployment of a **3-tier web application** using Kubernetes. We have written the Kubernetes manifest files to manage the various components, including **frontend**, **backend**, **SQL server**, and related configurations.

Each manifest file in this folder serves a specific purpose in ensuring the application runs smoothly in a containerized and orchestrated environment. Below, you'll find detailed explanations of what each file does and how they all work together.

---

## Kubernetes Manifests 🛠️

The Kubernetes manifest files in this repository define the resources and configurations needed to deploy the different components of our application. The files are written in **YAML** format and serve the following purposes:

- **Deployment**: Specifies how pods are created, which Docker images to use, and how scaling is managed.
- **Service**: Defines how network access is provided to pods.
- **Ingress**: Manages external access to the services, typically HTTP and HTTPS.
- **ConfigMap & Secrets**: Stores configuration data and sensitive information.
- **Persistent Volume (PV) & Persistent Volume Claim (PVC)**: Manages storage for the application.

---

## Files Overview 📂

| File Name                    | Description                                                                 |
|-------------------------------|-----------------------------------------------------------------------------|
| **`backend-deployment.yaml`** | Deploys the backend API service. Contains replicas, image details, and environment variables. |
| **`frontend-deployment.yaml`**| Deploys the frontend UI of the application. Handles scaling and image pulling. |
| **`sqlserver-deployment.yaml`**| Defines the SQL Server pod, its storage, and CPU/RAM requirements. |
| **`backend-service.yaml`**    | Exposes the backend service internally to the cluster.                       |
| **`frontend-service.yaml`**   | Exposes the frontend UI within the Kubernetes cluster.                       |
| **`sqlserver-service.yaml`**  | Internal service for database communication between backend and SQL Server.  |
| **`ingress.yaml`**            | Manages external access to the application, routing HTTP/HTTPS traffic to the correct services. |
| **`configmap.yaml`**          | Stores non-sensitive configuration data used by the backend and frontend.   |
| **`secrets.yaml`**            | Holds sensitive information like database credentials, stored securely.      |
| **`persistent-volume.yaml`**  | Describes the physical storage that the SQL Server can use.                  |
| **`persistent-volume-claim.yaml`** | Requests storage resources for SQL Server, tying it to the Persistent Volume. |

---

## How to Deploy 🧑‍💻

To deploy these Kubernetes manifests on your **Minikube** cluster, follow the steps below:

1. **Start Minikube**:
    ```bash
    minikube start
    ```

2. **Apply the manifests**:
    ```bash
    kubectl apply -f k8s-manifets/
    ```

3. **Verify the pods and services**:
    ```bash
    kubectl get pods
    kubectl get svc
    ```

4. **Check the Ingress** (if configured):
    ```bash
    minikube addons enable ingress
    kubectl get ingress
    ```

You can now access the application by visiting the Minikube IP and the Ingress route.

---

## Contributing 🤝

We welcome contributions to improve this project! Feel free to fork the repository, make changes, and submit a pull request. Please ensure your contributions adhere to our code of conduct.

---

## License 📜

This project is licensed under the **MIT License**. See the [LICENSE](../LICENSE) file for more details.

---

With these manifest files and the steps outlined above, you're set to run the application smoothly on a Kubernetes cluster using Minikube. If you have any questions or run into issues, don't hesitate to open an issue or contact us.

Enjoy orchestrating your cloud-native application! 🚀✨
