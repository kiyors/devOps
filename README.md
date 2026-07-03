# DevOps Deployment Blueprints

Welcome to this collection of self-hosted infrastructure blueprints. 

> **Note:** Unlike monolithic homelab repositories, **each folder here is designed to be deployed individually on its own server or isolated context**. They are standalone environments.

---

## 🏗️ Ecosystem Blueprints

Each folder contains its own `docker-compose.yml`, `.env.example`, and a `setup.sh` runbook to make deployment independent and straightforward.

| Blueprint | Description | Core Services |
| :--- | :--- | :--- |
| **[explorer](./explorer)** | Marketing Agency / Team Storage | Samba, NextExplorer, Authelia (SSO), LLDAP |
| **[hermes-agent](./hermes-agent)** | Autonomous Self-Improving AI | Hermes Gateway, Hermes Dashboard, OpenRouter |
| **[huly](./huly)** | Open-Source Project Management | Front, CockroachDB, Redpanda, Transactor |
| **[localstack](./localstack)** | Local AWS Cloud Emulation | S3, IAM, Lambda, API Gateway, EC2 |
| **[media](./media)** | Automated Media & Streaming Server | Jellyfin, *arr Suite, qBittorrent, Seerr |
| **[openvpn](./openvpn)** | Secure Remote Network Access | OpenVPN Server (kylemanna/openvpn) |

---

## 🌐 The Proxy Approach (Traefik)

To make deployments cleaner, this repository uses the **Traefik Proxy** approach instead of exposing raw ports on every server.

If you are deploying a blueprint (like `huly` or `media`), you can first deploy the **[proxy](./proxy)** stack on that server. The blueprints are configured with Traefik labels so they automatically route traffic via domain names (like `http://huly.yourdomain.com`) without you having to manually manage port mappings!
