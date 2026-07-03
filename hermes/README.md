# Hermes Agent: Autonomous Self-Improving AI

**Hermes Agent** is an autonomous, self-improving AI agent developed by **Nous Research**. It features a unique learning loop, allowing it to create skills from experience, persist knowledge, search past conversations, and build a persistent model of the user.

---

## 🏗️ Architecture & Strategy: Why These Tools?

This deployment configures the Hermes Agent into an always-on ecosystem capable of integrating with Telegram, Slack, Web, and more.

1.  **Hermes Gateway (The Core):** The main agent runtime that listens for commands, plans execution, handles memory persistence, and interacts with APIs.
2.  **Hermes Dashboard (The UI):** A graphical web interface for interacting with the agent, monitoring trajectories (thoughts), and managing skills.
3.  **Docker Backend (The Sandbox):** The agent mounts the host's `docker.sock` allowing it to safely spin up isolated containers to execute Python or Node code on the fly.
4.  **OpenRouter (The Brain):** Acts as the LLM provider router, allowing Hermes to seamlessly swap between Claude, GPT, Gemini, and open models.

---

## 📁 Directory Structure (The Root-Split)

We map a local volume to keep the agent's memory and skills persistent:

- **`/data`:** Bound to `/opt/data` inside the container. This folder stores:
  - SQLite databases for memory and conversation history.
  - Automatically learned skills and Python scripts.
  - Downloaded files and agent configuration (`config.yaml`).

---

## 🚀 Technical Implementation Guide (IT Runbook)

### Phase 1: Download & Setup

If you are deploying this on a new server and **only** want to download this specific stack (without cloning your entire devOps repository), you can use `svn` (easiest) or `git sparse-checkout`.

**Option A: SVN (Cleanest)**
```bash
svn export https://github.com/YOUR_GITHUB_USERNAME/devOps/trunk/hermes
cd hermes
just setup
```

**Option B: Git Sparse Checkout (If SVN isn't installed)**
```bash
git clone --depth 1 --filter=blob:none --sparse https://github.com/YOUR_GITHUB_USERNAME/devOps.git
cd devOps
git sparse-checkout set hermes
cd hermes
just setup
```

*Note: The `just setup` command will interactively ask for your API keys and automatically configure your `.env` file!*


### Phase 2: Deploying the Agent

Boot the agent core, the web dashboard, and the embedded Traefik proxy.

```bash
just up
```

> **Note:** The compose file explicitly binds `/var/run/docker.sock`. This allows the agent to create temporary secure containers for code execution (`TERMINAL_ENV=docker`), and allows Traefik to discover the containers.

### Phase 3: Accessing the Dashboard Locally

Because this stack uses Traefik for reverse proxy routing, the dashboard is not mapped to a direct IP/port. Instead, it expects traffic directed to `hermes.local`.

Since you are running this locally, you must tell your machine how to resolve this domain. You have three options:

**Option A: The `.localhost` Trick (Zero Config, Browser Only)**
Modify your `.env` file to use a `.localhost` domain before deploying. Modern web browsers automatically resolve anything ending in `.localhost` to `127.0.0.1`.
```env
DASHBOARD_DOMAIN=hermes.localhost
```
Then visit: **http://hermes.localhost**

**Option B: Edit Your Hosts File (System-Wide)**
If you want to stick with `hermes.local`, add it to your machine's hosts file.
On macOS/Linux, run: `sudo nano /etc/hosts` and add:
```
127.0.0.1    hermes.local
```
Then visit: **http://hermes.local**

**Option C: CLI Testing**
If you are testing the endpoints via terminal (like `curl`) without altering system DNS, you can pass the Host header manually:
```bash
curl -H "Host: hermes.local" http://localhost
```

---

## 🛠️ Maintenance & High Availability

- **Skill Evolution:** The agent writes and saves skills in the `./data/skills` directory. If it writes a broken skill, you can manually delete the Python file from this folder.
- **Context Compression:** The agent automatically compresses long conversations using summarizing LLM calls to prevent context window exhaustion.
- **Log Management:** Trajectories are heavily logged. You can review them via the Dashboard or natively in the `./data/logs` folder.

---

## 🔗 Connection Summary

| Service               | External Route / Domain                    | Protocol |
| :-------------------- | :----------------------------------------- | :------- |
| **Traefik Proxy**     | `http://localhost:80`                      | HTTP     |
| **Dashboard (Web UI)**| `http://hermes.local` (via Traefik)        | HTTP     |
| **Gateway API**       | *Internal Only* (No exposed port)          | HTTP     |
