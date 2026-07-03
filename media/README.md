# Ultimate Media & Automation Stack

This directory contains a complete, automated stack for acquiring, organizing, and streaming digital media.

---

## 🏗️ Architecture & Strategy: Why These Tools?

1. **Jellyfin (The Media Server):** A completely free, open-source alternative to Plex and Emby with hardware transcoding support.
2. **qBittorrent (The Downloader):** A lightweight, robust BitTorrent client.
3. **The *arr Suite (The Automators):**
   - **Sonarr:** TV Show automation.
   - **Radarr:** Movie automation.
   - **Lidarr:** Music automation.
   - **Bazarr:** Subtitle automation.
   - **Prowlarr:** Indexer proxy/manager for the *arr apps.
4. **Seerr & Reiverr (The Request Portals):** Allows your users to request media beautifully via the web.
5. **Jellystat (The Analytics):** Provides playback reporting and metrics for Jellyfin users.

---

## 📁 Directory Structure

All persistent application configurations are stored in their respective named folders (e.g., `./sonarr`, `./jellyfin`).
- **`/media`**: This is your master storage directory (mounted into all containers) where your actual video files reside.

---

## 🚀 Technical Implementation Guide (IT Runbook)

### Phase 1: Environment Setup

Run the setup script to copy the environment template and generate the necessary secrets for Jellystat.

```bash
./setup.sh
```

Ensure your `PUID` and `PGID` in the `.env` file match the host user running Docker to prevent permission issues with downloaded files.

### Phase 2: Deploying the Stack

```bash
docker compose up -d
```

### Phase 3: Hardware Transcoding (Optional)

Jellyfin is configured to pass `/dev/dri` to the container. If you have an Intel CPU with QuickSync or a supported AMD APU, enable Hardware Acceleration (VAAPI or QuickSync) in the Jellyfin Dashboard -> Playback settings to drastically reduce CPU usage during transcodes.

---

## 🔗 Connection Summary

| Service        | Host Port | Purpose                       |
| :------------- | :-------- | :---------------------------- |
| **Jellyfin**   | `8096`    | Media streaming frontend      |
| **Seerr**      | `5055`    | Media request portal          |
| **Jellystat**  | `3000`    | Media analytics dashboard     |
| **qBittorrent**| `8080`    | Download client WebUI         |
| **Sonarr**     | `8989`    | TV automation                 |
| **Radarr**     | `7878`    | Movie automation              |
| **Prowlarr**   | `9696`    | Indexer management            |
| **Bazarr**     | `6767`    | Subtitle management           |
| **Lidarr**     | `8686`    | Music automation              |

---

## 🛠️ Maintenance & Troubleshooting

- **File Permissions**: If the *arr applications (Sonarr/Radarr) cannot move files downloaded by qBittorrent, you have a permissions issue. Ensure `PUID` and `PGID` in `.env` match the host user that owns the `/media` folder.
- **Hardware Acceleration**: If video transcoding stutters, ensure the `/dev/dri` device exists on the host. You may need to install Intel media drivers (`intel-media-va-driver`) on the host system.
- **Updating**: Run `just down && docker compose pull && just up` to pull the latest image versions from LinuxServer.io.
