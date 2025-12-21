# Homelab Kubernetes Playground

## Project Overview

This project is a personal homelab setup designed to experiment with **Kubernetes, Helm, and Tekton pipelines** on a single-node cluster. The goal is to:

- Learn Kubernetes concepts and Helm chart management.
- Deploy applications such as **Deluge**, **Jellyfin**, and **ClamAV** in a fully containerized environment.
- Explore **event-driven automation** with **Tekton pipelines**, including triggers on download completion.
- Implement **reverse proxies and TLS** using **Nginx Ingress** and **cert-manager**.
- Centralize configuration and deployments via **GitHub** (GitOps style, future stage).

This is meant as a personal playground for learning infrastructure automation, CI/CD, and self-hosted media streaming.

---

## Why?
I just needed a repository to push my code to, feel free to steal it.

## Configuration
`kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/v0.0.32/deploy/local-path-storage.yaml`

### Terraform vars
```terraform
cloudflare_api_token = "<cloudflare api token>"
cloudflare_zone_id   = "<cloudflare zone id>"
homelab_ip_address   = "<external ip>"
root_domain = "<root domain>"
anubis_private_key = "<anubis private key>"
```

Most of the values can be configured from what you can find in cloudflare, for the other values, I suppose you know them 😅

Regarding the anubis private key, this needs to be a 32-bits string:
```shell
openssl genpkey -algorithm ED25519 -out ed25519.pem
openssl pkey -in ed25519.pem -outform DER | tail -c 32 | xxd -p -c 32
```
This will keep the pesky bots out.

### Secrets
All secrets are created via terraform, this does require a bit of configuration.

## Features
- Single-node **K3s Kubernetes cluster** running on a Mac Pro.
- Helm-managed applications:
    - **Deluge** (with deluge-web)
    - **Jellyfin** (media streaming)
    - **ClamAV** (virus scanning)
    - **Nginx Ingress** for reverse proxy
    - **Cert-manager** for TLS certificates
- **Tekton pipelines** for ephemeral scans, file processing, and alerts.
- Optional **Grafana + Prometheus** monitoring.
- Event-driven automation using **Tekton Triggers** (stage 2).

---

## Folder Structure
```
homelab/
├─ charts/ # Helm charts for apps
│ ├─ deluge/
│ │ ├─ Chart.yaml
│ │ ├─ templates/
│ │ └─ values.yaml
│ ├─ jellyfin/
│ │ ├─ Chart.yaml
│ │ ├─ templates/
│ │ └─ values.yaml
│ └─ nginx-ingress/
│ ├─ Chart.yaml
│ └─ values.yaml
├─ pipelines/ # Tekton pipelines and tasks
│ ├─ clamav-scan-pipeline.yaml
│ └─ deluge-post-process.yaml
├─ values/ # Global or override values for Helm charts
│ ├─ deluge-values.yaml
│ └─ jellyfin-values.yaml
├─ scripts/ # Helper scripts (e.g., Deluge Execute plugin hooks)
├─ README.md # Project overview (this file)
└─ LICENSE
```