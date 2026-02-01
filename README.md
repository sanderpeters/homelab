<p align="center">
    <img alt="" src=".github/banner.gif" />
</p>

<h1 align="center">Homelab Playground</h1>

![Kubernetes Badge](https://img.shields.io/badge/Kubernetes-326CE5?logo=kubernetes&logoColor=fff&style=flat)
![Helm Badge](https://img.shields.io/badge/Helm-0F1689?logo=helm&logoColor=fff&style=flat)
![OpenTofu Badge](https://img.shields.io/badge/OpenTofu-FFDA18?logo=opentofu&logoColor=000&style=flat)
![Python Badge](https://img.shields.io/badge/Python-3776AB?logo=python&logoColor=fff&style=flat)

This repository contains my personal homelab setup, built to experiment with Kubernetes, Helm, and other self-hosted tooling on a single-node cluster. The ultimate goal is to create a home-grown platform for streaming content to my devices around the house.

## Installation
![](.github/installation.gif)

In order to use the tools, the following must be run:
```shell
cd tools/
pyhton3 -m venv .venv
source .venv/bin/activate

pip install -e .
```

## Deployment
![Deploy](.github/deploy.gif)

The deployment can be done using the homelab CLI:
```shell
./bin/homelab deploy
```