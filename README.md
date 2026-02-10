# Home Lab Kubernetes Project

This repository contains the infrastructure-as-code and automation for my local Kubernetes cluster. It is a core part of my learning path toward becoming a **Junior DevOps Engineer**.

The entire process, including architectural decisions, troubleshooting, and implementations, is documented as a series of blog posts.

## 🚀 Project Overview

The goal of this project is to build a highly available, production-ready Kubernetes environment on a Proxmox cluster using industry-standard tools.

### What's Inside?

*   **`terraform/`**: Infrastructure as Code using the Proxmox BPG provider to provision virtual machines (Ubuntu) with optimized resource allocation.
*   **`ansible/`**: Automated configuration management:
    *   **K3s Installation**: High Availability setup with 3 Control Plane nodes and etcd.
    *   **Kube-VIP**: Floating IP (VIP) configuration for Control Plane High Availability.
    *   **ArgoCD Bootstrap**: Initializing GitOps for continuous delivery.
*   **`apps/`**: Kubernetes manifests and application configurations managed via GitOps:
    *   **Blog (Dev/Prod)**: Multi-environment deployment of the project's blog.
    *   **Traefik**: Ingress Controller for routing external traffic.
    *   **Cloudflared**: Secure tunnel for external access.
*   **`argocd/`**: Root Application and GitOps manifests to manage the cluster's state.

## 🛠️ Tech Stack

*   **Hypervisor:** Proxmox VE
*   **Provisioning:** Terraform
*   **Configuration:** Ansible
*   **Kubernetes:** K3s (HA Mode)
*   **High Availability:** Kube-VIP
*   **GitOps:** ArgoCD
*   **Ingress:** Traefik
*   **Networking:** Netgear Managed Switch (VLANs)

---
*Created as part of the DevOps Journey 2026.*
