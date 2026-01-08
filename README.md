# Cloud-Native EKS Backbone (Terraform + Ansible + AWS)

![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Ansible](https://img.shields.io/badge/ansible-%231A1918.svg?style=for-the-badge&logo=ansible&logoColor=white)
![Kubernetes](https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)

This project automates the **provisioning and full bootstrapping of an enterprise-ready EKS cluster**. It bridges the gap between raw infrastructure and a production-ready environment by integrating **Terraform** for AWS resources and **Ansible** for cluster-level configuration.

---

## 🚀 Project Overview

The goal is to provide a fully functional, observable, and cost-optimized Kubernetes backbone:
- **Terraform** provisions the EKS cluster, VPC, and Managed Node Groups.
- **FinOps Optimized:** Heavy use of **EC2 Spot Instances** to reduce costs by up to 70%.
- **Ansible** automates the deployment of essential "day-two" services:
  - **Ingress-Nginx** with AWS NLB integration.
  - **Cert-Manager** with Let's Encrypt for automated TLS.
  - **Observability:** Full Prometheus & Grafana stack.
  - **GitOps:** ArgoCD for declarative continuous delivery.

---

## 🏗️ Architecture



```text
                  ┌───────────────────────────────┐
                  │         Developer PC          │
                  │   Terraform + Ansible CLI     │
                  └───────────────┬───────────────┘
                                  │
                  ┌───────────────▼───────────────┐
                  │         Amazon EKS            │
                  │      (Control Plane)          │
                  └───────────────┬───────────────┘
                                  │
          ┌───────────────────────┴───────────────────────┐
          │                                               │
┌───────────────────┐                           ┌───────────────────┐
│  Managed Nodes    │                           │  Managed Nodes    │
│    (On-Demand)    │                           │      (Spot)       │
│  - Core Services  │                           │  - App Workloads  │
└───────────────────┘                           └───────────────────┘
          │                                               │
          └───────────┬───────────────────────┬───────────┘
                      │                       │
           ┌──────────▼──────────┐   ┌────────▼──────────┐
           │   Ingress Controller│   │   Observability   │
           │ (Nginx + AWS NLB)   │   │ (Prom+Grafana)    │
           └─────────────────────┘   └───────────────────┘
```
---

## 🛠️ Tech Stack

| Tool | Purpose |
| :--- | :--- |
| **Terraform** | Infrastructure as Code (VPC, EKS, Node Groups) |
| **Ansible** | Configuration management & automated Helm bootstrapping |
| **AWS EKS** | Managed Kubernetes Service (Control Plane) |
| **Helm** | Kubernetes package management for backbone services |
| **NGINX Ingress** | Traffic management with AWS NLB integration |
| **Cert-Manager** | Automated SSL/TLS certificates via Let's Encrypt |
| **Prometheus** | Time-series database for cluster metrics |
| **Grafana** | Data visualization and monitoring dashboards |
| **ArgoCD** | GitOps-based declarative continuous delivery |
---

## 🌟 Key Features

* **IaC Mastery:** Fully automated EKS provisioning using Terraform.
* **Automated Bootstrapping:** Post-deployment configuration via Ansible, ensuring the cluster is ready for workloads immediately.
* **FinOps & Cost Optimization:** Intelligent workload placement using **AWS EC2 Spot Instances** and custom `NodeSelectors` to reduce costs by up to 70%.
* **Safe Lifecycle Management:** Dedicated **Cleanup Playbook** ensures all cloud resources (like dynamic NLBs) are destroyed, preventing orphaned AWS costs.

---

## 🛠️ Quick Start

### Prerequisites

#### 1. System Tools
* **AWS CLI** (configured via `aws configure`)
* **Terraform** (>= 1.0.0)
* **Ansible** (>= 2.15)
* **kubectl** & **helm**
* **k9s** (highly recommended for cluster management)

#### 2. Python Environment
The Ansible Kubernetes modules require the `kubernetes` Python library. Install it using the following command:

```bash
pip install kubernetes
````

#### 3. Ansible Collections
Install the required collection for Kubernetes and Helm integration:

```bash
ansible-galaxy collection install kubernetes.core
```

### Step 1: Provision Infrastructure
```bash
cd terraform

# Run terraform
terraform init
terraform apply -auto-approve
```

### Step 2: Bootstrap Cluster
```bash
cd ../ansible

# Run the playbook
ansible-playbook -i inventory.yaml playbook.yaml
```
---
## 🧠 Key Features
#### ✅ Spot Instance Integration: Automated scheduling via NodeSelectors for cost optimization.

#### ✅ Idempotent Deployments: Playbooks can be run multiple times safely.

#### ✅ Unified Auth: Automated kubeconfig updates and cluster verification.

#### ✅ Full Observability: Pre-configured Grafana dashboards for cluster monitoring.

#### ✅ Safe Cleanup: Dedicated cleanup.yaml to ensure no "orphaned" AWS Load Balancers remain.

---

## 🧹 Cleanup & Cost Control

To prevent unwanted AWS charges (especially for Load Balancers):

#### 1. Remove K8s Addons (Deletes AWS NLB):

```bash
ansible-playbook -i inventory.yaml cleanup.yaml
```

#### 2. Destroy AWS Infrastructure:

```bash
cd ../terraform
terraform destroy -auto-approve
```
---

## 🧑‍💻 Author
- Jakub Jasiński
- Cloud & DevOps Engineer
- 🌐 github.com/KoJotPG