# DevOps Homelab & Self-Hosted Stack

Welcome to the central repository for all self-hosted infrastructure. This project uses Docker Compose to deploy, manage, and isolate various enterprise and media applications.

---

## 🏗️ Ecosystem Overview

This repository is split into distinct application stacks. Each folder contains its own `docker-compose.yml`, `.env.example`, and a `setup.sh` runbook to make deployment a breeze.

| Stack | Description | Core Services |
| :--- | :--- | :--- |
| **[explorer](./explorer)** | Marketing Agency / Team Storage | Samba, NextExplorer, Authelia (SSO), LLDAP |
| **[hermes-agent](./hermes-agent)** | Autonomous Self-Improving AI | Hermes Gateway, Hermes Dashboard, OpenRouter |
| **[huly](./huly)** | Open-Source Project Management | Front, CockroachDB, Redpanda, Transactor |
| **[localstack](./localstack)** | Local AWS Cloud Emulation | S3, IAM, Lambda, API Gateway, EC2 |
| **[media](./media)** | Automated Media & Streaming Server | Jellyfin, *arr Suite, qBittorrent, Seerr |
| **[openvpn](./openvpn)** | Secure Remote Network Access | OpenVPN Server (kylemanna/openvpn) |
| **[proxy](./proxy)** | Global Reverse Proxy | Traefik |

---

## 🚦 Global Port Mapping

To prevent collisions on your host machine, services are statically mapped to the following ports. If you enable the **Traefik Proxy**, you can access them via local domains (e.g. `http://media.local`) instead of remembering ports!

| Service | Host Port | Protocol / Purpose |
| :--- | :--- | :--- |
| **Traefik Proxy** | `80` / `443` | HTTP / HTTPS Global Router |
| **OpenVPN** | `1194` | UDP / VPN Tunnel |
| **Media: Jellyfin** | `8096` | HTTP / Video Streaming |
| **Media: Seerr** | `5055` | HTTP / Media Requests |
| **Media: qBittorrent**| `8080` / `6881`| HTTP / P2P |
| **Huly** | `8087` | HTTP / Workspace UI |
| **Hermes Agent UI** | `9119` | HTTP / AI Dashboard |
| **Hermes Gateway**| `8000` | HTTP / AI API |
| **LocalStack** | `4566` | HTTP / AWS Gateway |
| **Authelia (SSO)**| `9091` | HTTP / Identity Provider |

---

## 🛠️ Global Makefile Usage

You can use the root `Makefile` to manage your entire ecosystem without having to `cd` into every directory.

```bash
# Start a specific stack (e.g., media)
make up-media

# Stop a specific stack
make down-huly

# Check logs for a stack
make logs-hermes-agent

# Tear down the entire homelab (Use with caution!)
make down-all
```
