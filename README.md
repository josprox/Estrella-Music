<div align="center">

<img src="icon.png" width="120" height="120" alt="Estrella Music" style="border-radius:28px"/>

<h1>Estrella Music v2</h1>

<p><strong>Offline-First Cross-Platform Music Player · Flutter · Modular Music Providers</strong></p>

<!-- Badges -->
<p>
  <a href="https://github.com/josprox/Estrella-Music/releases/latest">
    <img src="https://img.shields.io/github/v/release/josprox/Estrella-Music?style=for-the-badge&logo=github&logoColor=white&label=Release&color=FF719A" alt="Latest Release"/>
  </a>
  <a href="https://github.com/josprox/Estrella-Music/releases/latest">
    <img src="https://img.shields.io/github/downloads/josprox/Estrella-Music/total?style=for-the-badge&logo=github&logoColor=white&color=7C3AED" alt="Total Downloads"/>
  </a>
  <a href="LICENSE">
    <img src="https://img.shields.io/badge/License-GPLv3-blue?style=for-the-badge&logo=gnu&logoColor=white" alt="License"/>
  </a>
  <img src="https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter"/>
  <img src="https://img.shields.io/badge/Platforms-Android%20·%20Windows%20·%20Linux%20·%20macOS%20·%20iOS-4CAF7D?style=for-the-badge&logo=flutter&logoColor=white" alt="Platforms"/>
</p>

<!-- Download buttons -->
<p>
  <a href="https://github.com/josprox/Estrella-Music/releases/latest/download/EstrellaMusic-android-universal.apk">
    <img src="https://img.shields.io/badge/Android-APK-3DDC84?style=for-the-badge&logo=android&logoColor=white" alt="Download Android"/>
  </a>
  <a href="https://github.com/josprox/Estrella-Music/releases/latest/download/EstrellaMusic-windows-installer.exe">
    <img src="https://img.shields.io/badge/Windows-Installer-0078D4?style=for-the-badge&logo=windows&logoColor=white" alt="Download Windows"/>
  </a>
  <a href="https://github.com/josprox/Estrella-Music/releases/latest/download/EstrellaMusic-linux-x64.tar.gz">
    <img src="https://img.shields.io/badge/Linux-x64-FCC624?style=for-the-badge&logo=linux&logoColor=black" alt="Download Linux"/>
  </a>
  <a href="https://github.com/josprox/Estrella-Music/releases/latest/download/EstrellaMusic-macos.zip">
    <img src="https://img.shields.io/badge/macOS-ZIP-000000?style=for-the-badge&logo=apple&logoColor=white" alt="Download macOS"/>
  </a>
</p>

</div>

---

## ✨ What is Estrella Music v2?

**Estrella Music v2** is a modern, high-performance, **offline-first local music player** built with Flutter for Android, Windows, Linux, macOS, and iOS. 

Designed around a neutral, extensible **MusicProvider** architecture, Estrella Music works out-of-the-box as a powerful local audio manager that scans and organizes your device's audio files without requiring an active internet connection.

> 🔒 **Identity by Joss Red**: The app requires a global Joss Red account session for profile management, friend lists, and encrypted backups.
>
> ⚠️ **Disclaimer of Liability**: External streaming reproductions and community recipe servers are user-configured external sources. Estrella Music and its developers assume no responsibility for external content or third-party usage.

---

## 🏗️ Project Architecture & Ecosystem Separation

This repository and ecosystem consist of three distinct components:

```
┌────────────────────────────────────────┐       JWT / Auth       ┌──────────────────────────────┐
│       Estrella Music (Flutter)         │ ─────────────────────► │          Joss Red            │
│  ────────────────────────────────────  │                        │   Primary Identity & Auth    │
│  • Default Offline-First Music Player  │                        │   User Profiles · Backups    │
│  • Smart local audio scanning & tags   │                        │   Friends & Social Features  │
│  • Neutral Multi-Profile Player        │                        └──────────────────────────────┘
│  • External Recipe / URL / QR Support  │
└────────────────────────────────────────┘
                    │ (Optional Sync / Streaming)
                    ▼
       ┌──────────────────────────┐
       │     EMusic (Secondary)   │
       │  Standalone Cloud Backend│
       │  Music Sync & Shared Queues
       └──────────────────────────┘
```

1. **Flutter App (`/`) [Core Project]**: The default client application and real user experience. Operates as an offline-first local audio player with intelligent metadata enrichment, playlist management, and dynamic theme engine.
2. **Joss Red [Primary Identity Service]**: The core backend responsible for authentication, JWT verification, profile updates, encrypted backups, friends, and permissions.
3. **`EMusic/` [Secondary Standalone Service]**: A secondary, optional Joss backend dedicated to cloud music synchronization, co-listening, and legacy streaming. **EMusic is NOT part of the core Flutter client**.

---

## 🚀 Key Features

<table>
<tr>
<td width="50%">

### 🎧 Local Playback (Default Mode)
- **100% Offline-first local player**: No internet needed for audio playback.
- **Smart Directory Indexer**: Filters out noise (voice notes, WhatsApp audio, ringtones).
- **Composite Metadata Provider**: Enriches tags & high-resolution album artwork (iTunes & MusicBrainz).
- **Directory Sidecar Artwork**: Auto-detects `cover.jpg`, `folder.png`, embedded tags.
- **High-Fidelity Audio**: Gapless playback, equalizer, skip silence, persistent queue.
- **Synced Lyrics**: Time-synced and plain lyrics via LRCLIB.

</td>
<td width="50%">

### 🌐 Modular Providers & Streaming
- **Neutral MusicProvider Contract**: Decoupled player core.
- **External Streaming & Recipes (Stremio-style)**: Connect custom recipe servers or community endpoints.
- **QR Code & URL Scanner**: Import custom server endpoints instantly via camera or clipboard.
- **Multi-Profile Support**: Switch between multiple local and external profiles seamlessly.
- **Joss Red Cloud Backups**: Securely back up playlists and settings to your Joss Red account.

</td>
</tr>
</table>

---

## 📲 Conectar Servidor de Streaming Externo (QR & URL)

Si deseas conectar el servidor de streaming externo (`https://emusic.joss.red`), puedes escanear este código QR directamente con la cámara de la aplicación o ingresar la URL manualmente:

<div align="center">

<img src="assets/qr_emusic.png" width="190" height="190" alt="QR EMusic Server" style="border-radius:14px; margin: 12px 0; border: 1px solid rgba(255,255,255,0.15);"/>

```text
https://emusic.joss.red
```

<p><em>En la app: Selecciona <strong>Reproducción de streaming externo</strong> → Toca el botón de <strong>Escanear QR</strong> y enfoca este código.</em></p>

</div>

---

## 📸 Screenshots

<div align="center">
<p><em>Library, Wrap & Stats Screens</em></p>

<table>
  <tr>
    <td><img src="assets/screenshots/v1_wrapped_artist.png" height="340" alt="Top Artist"/></td>
    <td><img src="assets/screenshots/v1_top_artists.png" height="340" alt="Top Artists List"/></td>
    <td><img src="assets/screenshots/v1_wrapped_song.png" height="340" alt="Song of the Year"/></td>
    <td><img src="assets/screenshots/v1_top_songs.png" height="340" alt="Top Songs"/></td>
    <td><img src="assets/screenshots/v1_stats.png" height="340" alt="Your Stats"/></td>
    <td><img src="assets/screenshots/v1_wrapped_end.png" height="340" alt="Wrapped 2025"/></td>
  </tr>
</table>
</div>

---

## 🛠 Tech Stack

| Layer | Technology |
|---|---|
| **Framework** | [Flutter](https://flutter.dev) 3.x · Dart |
| **Architecture** | Neutral `MusicProvider` (`LocalMusicProvider`, `EMusicProvider`, Custom) |
| **State Management** | [GetX](https://pub.dev/packages/get) |
| **Mobile Audio** | `just_audio` · `audio_service` |
| **Desktop Audio** | `media_kit` via `just_audio_media_kit` |
| **Local Storage & State** | Hive (local state, downloads & offline caching) · SQLite (profiles & outbox) |
| **Identity & Sessions** | **Joss Red** (JWT · profiles · cloud backups · friends) |
| **QR & Scanner** | `mobile_scanner` |
| **Lyrics & Metadata** | LRCLIB · iTunes API · MusicBrainz |
| **Build & Release** | GitHub Actions multi-platform CI/CD |

---

## 📥 Installation

### Android / Windows / Linux / macOS

Download the latest release for your platform:

| Platform | File | Notes |
|---|---|---|
| 🤖 **Android** | `EstrellaMusic-android-universal.apk` | Universal APK — also available split by ABI |
| 🪟 **Windows** | `EstrellaMusic-windows-installer.exe` | Inno Setup installer |
| 🐧 **Linux** | `EstrellaMusic-linux-x64.tar.gz` | Requires `libmpv` + `libgtk-3` |
| 🍎 **macOS** | `EstrellaMusic-macos.zip` | Extract & drag to Applications. If Gatekeeper blocks it: **right-click → Open** |
| 🐙 **All** | [GitHub Releases →](https://github.com/josprox/Estrella-Music/releases/latest) | |

---

### 🍏 iPhone / iOS — Automatic Signing with SideStore

To install the `.ipa` without weekly revokes:

1. **Install SideStore** following [sidestore.io](https://sidestore.io).
2. **Install the App:**
   - Download `EstrellaMusic-ios-unsigned.ipa` on your iPhone → **Files**.
   - SideStore → **My Apps** → **`+`** → select the `.ipa` file.
3. **Auto-renewal:** Open SideStore on Wi-Fi once a week to renew signatures automatically.

---

### 🧑‍💻 Build from source

```bash
# 1. Clone
git clone https://github.com/josprox/Estrella-Music.git
cd Estrella-Music

# 2. Environment
cp .env.example .env
# Edit .env — configure API endpoints if needed

# 3. Dependencies
flutter pub get

# 4. Run
flutter run
```

---

## 📜 License & Authorship

**Copyright © 2026 Joss Estrada (JOSPROX). All rights reserved.**

Licensed under the **[GNU General Public License v3.0](LICENSE)**.

- You may not use modified versions for non-free or commercial purposes.
- You may not publish modified versions on closed-source stores without authorization.
- See [CREDITS.md](CREDITS.md) for full third-party acknowledgments.

*This project is an independent open-source audio player and is not affiliated with external streaming platforms. All trademarks belong to their respective owners.*

---

<div align="center">

Made with ❤️ by **[JOSPROX](https://github.com/josprox)**

</div>
