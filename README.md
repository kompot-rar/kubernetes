# Home Lab Kubernetes Project

This repository contains the infrastructure-as-code and automation for my local Kubernetes cluster. It is a core part of my learning path toward becoming a **Junior DevOps Engineer**.

The entire process, including architectural decisions, troubleshooting, and implementations, is documented as a series of blog posts.

## 🚀 Project Overview

The goal of this project is to build a highly available, production-ready Kubernetes environment on a Proxmox cluster using industry-standard tools.

### What's Inside?

*   **`terraform/`**: Infrastructure as Code using the Proxmox BPG provider to provision virtual machines (Ubuntu) with optimized resource allocation.
*   **`ansible/`**: Automated configuration management:
    *   **K3s Installation**: Lightweight Kubernetes distribution setup.
    *   **Kube-VIP**: High Availability (HA) configuration for the Control Plane.
    *   **ArgoCD Bootstrap**: Initializing GitOps for continuous delivery.
*   **`argocd/`**: Root Application and GitOps manifests to manage the cluster's state.

## 🛠️ Tech Stack

*   **Hypervisor:** Proxmox VE
*   **Provisioning:** Terraform
*   **Configuration:** Ansible
*   **Kubernetes:** K3s
*   **GitOps:** ArgoCD
*   **Networking:** Netgear Managed Switch (VLANs)

---
*Created as part of the DevOps Journey 2026.*
