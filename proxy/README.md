# Traefik Reverse Proxy

**Traefik** is a modern HTTP reverse proxy and load balancer that makes deploying microservices easy. It automatically discovers the right configuration for your services by inspecting Docker containers.

---

## 🏗️ Architecture & Strategy

Instead of mapping a dozen different ports on your host (e.g., `8080`, `9119`, `8096`), we run Traefik to bind only to ports `80` (HTTP) and `443` (HTTPS). 

When you deploy a new application (like Media or Huly), Traefik reads the `labels` attached to that container in its `docker-compose.yml` and automatically routes traffic to it based on the domain name.

---

## 🚀 Technical Implementation Guide

### Phase 1: Deploying the Proxy

This should be the **first** thing you deploy on any new server.

```bash
just up
```

This creates the `global_proxy_net` Docker network. Other applications will attach to this network to communicate with Traefik.

### Phase 2: Connecting Apps to the Proxy

To route a new application through this proxy, you add three things to its `docker-compose.yml`:

1.  **Network Attachment**: Ensure it connects to `global_proxy_net`.
2.  **Enable Traefik**: `traefik.enable=true`
3.  **Routing Rule**: `traefik.http.routers.<app>.rule=Host('app.local')`

*Note: All blueprints in this repository (like `huly`, `media`, and `hermes-agent`) are already pre-configured with these labels!*

---

## 🩺 Troubleshooting & Diagnostics

- **Dashboard**: By default, the Traefik dashboard is exposed on port `8080`. You can access it to see a visual map of all connected services and routing rules.
- **502 Bad Gateway**: This usually means Traefik found the container, but the container hasn't finished booting up yet, or the internal port defined in the labels is incorrect.
