# Huly: Open Source Project Management & Collaboration

**Huly** is a powerful open-source platform providing task management, team collaboration, CRM, and HR management. This ecosystem is designed to be a unified workspace alternative to Linear, Jira, and Slack.

---

## 🏗️ Architecture & Strategy: Why These Tools?

This deployment represents the latest `v0.7+` architecture for Huly, optimized for reliability and scale:

1.  **Nginx (The Web Bridge):** Secure reverse proxy handling sub-route distribution (e.g., `/_accounts`, `/_collaborator`, `/_rekoni`) with internal configurations compiled dynamically at boot.
2.  **CockroachDB (The Heavy Lifter):** Replaced MongoDB as the primary distributed SQL database. Provides high availability and transactional consistency for all workspaces.
3.  **Redpanda (The Event Bus):** High-performance, Kafka-compatible queue mechanism handling asynchronous jobs, webhooks, and push notifications.
4.  **Elasticsearch (The Search Engine):** Provides full-text, global search across projects, tasks, attachments, and user profiles.
5.  **MinIO (The Object Store):** S3-compatible storage handling avatars, document attachments, and project files.
6.  **Core Microservices:**
    - `front`: Serves the primary Vue-based user interface.
    - `transactor` & `account`: Handle core data logic, auth, and mutations.
    - `collaborator` & `rekoni`: Power real-time web-sockets, presences, and internal tools.

---

## 📁 Directory Structure (The Root-Split)

We use Docker named volumes to maintain strict separation of concerns for data persistence:

- **`cr_data` / `cr_certs`:** Persistent storage for CockroachDB tables and TLS configurations.
- **`elastic`:** Elasticsearch indexes.
- **`files`:** MinIO blob storage.
- **`redpanda`:** Queue storage and partitions.

---

## 🚀 Technical Implementation Guide (IT Runbook)

### Phase 1: Security Hardening & Initialization

Ensure you configure the secrets before launching the stack. In a production environment, generate strong hexadecimal strings.

```bash
# Generate secure secrets for the environment
openssl rand -hex 32 # Use for SECRET
openssl rand -hex 32 # Use for CR_USER_PASSWORD
openssl rand -hex 32 # Use for REDPANDA_ADMIN_PWD
```

### Phase 2: Deploying the Stack

This stack is self-contained. The Nginx configuration is securely injected into the container at boot, removing the need for local `.conf` files.

1. **Update Environment Variables**: Open `docker-compose.yml` and replace the placeholder secrets (`generate_a_secure_random_secret_here`, `cockroachsecret`, etc.) with your generated keys. Also, ensure `FRONT_URL` matches your deployment domain.
2. **Launch Services**:
   ```bash
   docker compose up -d
   ```
3. **Wait for Initialization**: Huly contains a complex web of microservices. Allow 60-90 seconds for CockroachDB to bootstrap and for Redpanda to establish its topics.

### Phase 3: External Routing & SSL (Dokploy/Traefik)

If deploying via Dokploy or a separate Traefik instance, point the external router to the `nginx` container on port **80**. Nginx will internally proxy WebSocket connections and rewrite paths for the various microservices.

---

## 🛠️ Maintenance & High Availability

- **Database Backups:** Back up the `cr_data` volume regularly. CockroachDB also supports native SQL dumps via the CLI.
- **Resource Limits:** Huly relies on Java (Elasticsearch) and C++ (Redpanda) binaries. Ensure the host has at least **4GB RAM** (8GB recommended).
- **Log Management:** To view live errors across the mesh, run: `docker compose logs -f`.

---

## 🔗 Connection Summary

| Service               | Internal Port | External Visibility                       |
| :-------------------- | :------------ | :---------------------------------------- |
| **Nginx Proxy**       | `80`          | Public (`http://${FRONT_URL}`)            |
| **MinIO Console**     | `9001`        | Internal Only (Forward via SSH if needed) |
| **CockroachDB Admin** | `8080`        | Internal Only                             |
| **Elasticsearch**     | `9200`        | Internal Only                             |
