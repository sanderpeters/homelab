<p align="center">
    <img alt="" src=".github/assets/banner.gif" />
</p>

<h1 align="center">Homelab Playground</h1>

![Kubernetes Badge](https://img.shields.io/badge/Kubernetes-326CE5?logo=kubernetes&logoColor=fff&style=flat)
![Helm Badge](https://img.shields.io/badge/Helm-0F1689?logo=helm&logoColor=fff&style=flat)
![Argo Badge](https://img.shields.io/badge/Argo-EF7B4D?logo=argo&logoColor=fff&style=flat)
![OpenTofu Badge](https://img.shields.io/badge/OpenTofu-FFDA18?logo=opentofu&logoColor=000&style=flat)
![Cloudflare Badge](https://img.shields.io/badge/Cloudflare-F38020?logo=cloudflare&logoColor=fff&style=flat)
![Ansible Badge](https://img.shields.io/badge/Ansible-E00?logo=ansible&logoColor=fff&style=flat)

This repository contains my personal homelab setup, built to experiment with Kubernetes, Helm, and other self-hosted tooling on a single-node cluster. The ultimate goal is to create a home-grown platform for streaming content to my devices around the house.

## Deployment
![Deploy](.github/assets/deploy.gif)

The node can be updated by using the ansible task
```shell
task ansible
```

The other parts can be rolled out by using OpenTofu and the helm charts.