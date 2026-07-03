# OpenVPN: Secure Remote Access

**OpenVPN** provides a robust, encrypted tunnel to securely access your homelab or private networks from anywhere in the world.

---

## 🏗️ Architecture & Strategy: Why These Tools?

This deployment uses the highly regarded `kylemanna/openvpn` image. It drastically simplifies the complex process of running a VPN server and managing Public Key Infrastructure (PKI).

1. **OpenVPN Server:** Handles encrypted UDP connections on port 1194.
2. **EasyRSA (Embedded):** Manages the Certificate Authority (CA) to generate client configurations securely.

---

## 📁 Directory Structure

- **`./openvpn-data/conf`**: Bound to `/etc/openvpn`. This persists your CA, server certificates, and client profiles. Keep this directory secure!

---

## 🚀 Technical Implementation Guide (IT Runbook)

### Phase 1: Initialization & PKI Setup

Run the setup script to initialize the Certificate Authority and configure the VPN for your domain.

```bash
./setup.sh
```
*Note: You will be prompted to set a passphrase for your Certificate Authority (CA). Do not lose this passphrase, as you need it to generate client certificates.*

### Phase 2: Deploying the Server

Once initialized, start the VPN server:
```bash
docker compose up -d
```

### Phase 3: Generating Client Profiles

To generate an `.ovpn` file for a new device (e.g., your iPhone or laptop):

```bash
docker compose run --rm openvpn easyrsa build-client-full CLIENT_NAME nopass
docker compose run --rm openvpn ovpn_getclient CLIENT_NAME > CLIENT_NAME.ovpn
```

Transfer the resulting `CLIENT_NAME.ovpn` file securely to your device.

---

## 🔗 Connection Summary

| Service               | Host Port | Protocol | Purpose                                    |
| :-------------------- | :-------- | :------- | :----------------------------------------- |
| **OpenVPN Tunnel**    | `1194`    | UDP      | Inbound encrypted client connections       |
