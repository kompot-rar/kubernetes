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
*   **`manifests/`**: Kubernetes manifests and application configurations managed via GitOps:
    *   **Blog (Dev/Prod)**: Multi-environment deployment of the project's blog.
    *   **Fishky**: Android flashcard app used to practice multi-container orchestration (Backend, Redis, Workers, and a local Python/ONNX TTS synthesis engine).
    *   **Fishky Frontend**: Next.js-based marketing landing page for the flashcard app, featuring a newsletter subscription form integrated with the Resend API.
    *   **Fishky Dashboard**: Administration panel utilizing custom Kubernetes ServiceAccounts and RBAC permissions to monitor cluster-level worker queue status and backend resources.
    *   **Fixtime**: Time-tracking system featuring a Go backend using WebSockets (single-replica deployment) and a dedicated PostgreSQL instance.
    *   **Forgejo**: Private Git server for learning Helm automation and stateful app persistence.
    *   **Mrozy Landing**: A client landing page deployed as a dual-replica web application.
    *   **NFS Provisioners (HDD & SSD)**: Storage-class bridges separating HDD storage (`nfs-client`) from SSD storage (`nfs-client-ssd`) to learn multi-tier PV lifecycles and latency optimization for databases.
    *   **Traefik**: Ingress Controller for routing external traffic.
    *   **Cloudflared**: Secure tunnel for external access.
    *   **Prometheus Stack**: Full observability solution collecting metrics from K3s nodes and Proxmox hosts.
    *   **Status Proxy**: A custom Node.js microservice that securely exposes real-time hardware metrics (CPU temp, RAM, uptime) to the public blog frontend via internal API.
*   **`argocd/`**: Root Application and GitOps manifests to manage the cluster's state.

## 📊 Real-Time Hardware Monitoring

One of the key features of this project is the integration between the infrastructure and the frontend application.

*   **Data Flow**: `Node Exporter` -> `Prometheus` -> `Status Proxy (Internal API)` -> `Cloudflare Tunnel` -> `React Frontend`.
*   **Why?**: To demonstrate a secure way of exposing internal infrastructure metrics (like CPU temperature of the Lenovo Tiny nodes) to the public internet without exposing the entire monitoring stack.
*   **Tech**: The proxy aggregates PromQL queries in real-time, handling data normalization for both Intel and AMD processors in the cluster.

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
