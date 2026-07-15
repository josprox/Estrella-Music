<div align="center">

<img src="icon.png" width="120" height="120" alt="Estrella Music" style="border-radius:28px"/>

<h1>Estrella Music v2</h1>

<p><strong>Cross-platform music streaming · Flutter · YouTube Music</strong></p>

<!-- Badges -->
<p>
  <a href="https://github.com/josprox/Estrella-Music-v2/releases/latest">
    <img src="https://img.shields.io/github/v/release/josprox/Estrella-Music-v2?style=for-the-badge&logo=github&logoColor=white&label=Release&color=FF719A" alt="Latest Release"/>
  </a>
  <a href="https://github.com/josprox/Estrella-Music-v2/releases/latest">
    <img src="https://img.shields.io/github/downloads/josprox/Estrella-Music-v2/total?style=for-the-badge&logo=github&logoColor=white&color=7C3AED" alt="Total Downloads"/>
  </a>
  <a href="LICENSE">
    <img src="https://img.shields.io/badge/License-GPLv3-blue?style=for-the-badge&logo=gnu&logoColor=white" alt="License"/>
  </a>
  <img src="https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter"/>
  <img src="https://img.shields.io/badge/Platforms-Android%20·%20Windows%20·%20Linux%20·%20macOS%20·%20iOS-4CAF7D?style=for-the-badge&logo=flutter&logoColor=white" alt="Platforms"/>
</p>

<!-- Download buttons -->
<p>
  <a href="https://github.com/josprox/Estrella-Music-v2/releases/latest/download/EstrellaMusic-android-universal.apk">
    <img src="https://img.shields.io/badge/Android-APK-3DDC84?style=for-the-badge&logo=android&logoColor=white" alt="Download Android"/>
  </a>
  <a href="https://github.com/josprox/Estrella-Music-v2/releases/latest/download/EstrellaMusic-windows-installer.exe">
    <img src="https://img.shields.io/badge/Windows-Installer-0078D4?style=for-the-badge&logo=windows&logoColor=white" alt="Download Windows"/>
  </a>
  <a href="https://github.com/josprox/Estrella-Music-v2/releases/latest/download/EstrellaMusic-linux-x64.tar.gz">
    <img src="https://img.shields.io/badge/Linux-x64-FCC624?style=for-the-badge&logo=linux&logoColor=black" alt="Download Linux"/>
  </a>
  <a href="https://github.com/josprox/Estrella-Music-v2/releases/latest/download/EstrellaMusic-macos.zip">
    <img src="https://img.shields.io/badge/macOS-ZIP-000000?style=for-the-badge&logo=apple&logoColor=white" alt="Download macOS"/>
  </a>
</p>

<br/>

<img src="cover.png" width="860" alt="Estrella Music v2 — cover"/>

</div>

---

## ✨ What is Estrella Music v2?

**Estrella Music v2** is the full Flutter evolution of the original [Estrella Music (Kotlin)](https://github.com/josprox/Joss-Music). Built on top of the powerful [Harmony Music](https://github.com/anandnet/Harmony-Music) engine and deeply integrated with the **YouTube Music** ecosystem, v2 brings a premium cross-platform experience to Android, Windows, Linux, macOS, and iOS — with cloud sync powered by [EMusic](https://emusic.josprox.com) and identity by **Joss Red**.

> **Migrate seamlessly** from your old `song.db` or `.backup` files. Your playlists, history, and favorites come with you.

---

## 🚀 Features

<table>
<tr>
<td width="50%">

### 🎵 Streaming & Playback
- Stream millions of songs, albums & playlists via YouTube Music
- High-quality audio with smart chunk caching
- Gapless playback & skip silence
- Background playback with native media controls
- Radio / continuous discovery mode

### 📜 Library & Discovery
- Local library management (songs, albums, artists)
- Synced & plain-text lyrics via **LRCLIB**
- Playlist import (YouTube Music, Piped)
- Persistent playback queue

</td>
<td width="50%">

### ☁️ Cloud & Sync *(EMusic)*
- Cloud library sync via **EMusic** server
- Offline downloads with authorized metadata
- Conflict-free incremental sync with queue
- Multi-device support with Joss Red identity

### 🖥️ Cross-Platform
- **Android** — Material 3 UI + Android Auto
- **Windows & Linux** — Desktop sidebar + tray
- **macOS** — Native macOS window management
- **iOS** — Unsigned IPA via SideStore

### 🔐 Auth & Updates
- Identity via **Joss Red** (JWT, profile, backups)
- In-app updater with per-platform download & install
- Blocking update gate with world-class UI

</td>
</tr>
</table>

---

## 📸 Screenshots

<div align="center">
<p><em>Wrap · Stats · Library — from the Estrella Music legacy (v1 Kotlin)</em></p>

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

<p><em>v2 Flutter — cross-platform engine (Android · Windows · Linux)</em></p>
<img src="cover.png" width="780" alt="Estrella Music v2 cover"/>
</div>

---

## 🛠 Tech Stack

| Layer | Technology |
|---|---|
| **Framework** | [Flutter](https://flutter.dev) 3.x · Dart |
| **State** | [GetX](https://pub.dev/packages/get) |
| **Audio (Android/iOS)** | `just_audio` |
| **Audio (Desktop)** | `media_kit` via `just_audio_media_kit` |
| **Networking** | [Dio](https://pub.dev/packages/dio) · [YouTube Explode](https://pub.dev/packages/youtube_explode_dart) |
| **Database** | SQLite (`sqlite3`) with legacy Hive migration |
| **Auth & Identity** | Joss Red (JWT · profile · backups · friends) |
| **Cloud Music** | EMusic (playlists · sync · offline · history) |
| **Notifications** | `flutter_local_notifications` · Firebase Messaging |
| **Build & Release** | GitHub Actions — multi-platform · draft releases |

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
| 🐙 **All** | [GitHub Releases →](https://github.com/josprox/Estrella-Music-v2/releases/latest) | |

> The in-app updater will notify you and handle download + installation automatically on Android and Windows.

---

### 🍏 iPhone / iOS — Re-firma automática con SideStore

Para instalar el `.ipa` sin que la firma expire a los 7 días:

1. **Instalar SideStore** siguiendo la guía oficial de [sidestore.io](https://sidestore.io) (requiere ordenador para la carga inicial + VPN WireGuard interna).
2. **Configurar el servidor Anisette de EMusic:**
   - SideStore → **Settings** → **Anisette Server URL**
   - Reemplaza con: `https://emusic.joss.red/api/anisette`
   - Inicia sesión con tu Apple ID dentro de SideStore.
3. **Instalar la App:**
   - Descarga `EstrellaMusic-ios-unsigned.ipa` en tu iPhone → **Archivos**.
   - SideStore → **My Apps** → **`+`** → selecciona el `.ipa`.
4. **Renovación automática:** Abre SideStore en Wi-Fi una vez a la semana y las firmas se renuevan en segundo plano.

---

### 🧑‍💻 Build from source

```bash
# 1. Clone
git clone https://github.com/josprox/Estrella-Music-v2.git
cd Estrella-Music-v2

# 2. Environment
cp .env.example .env
# Edit .env — set API_URL, JOSSRED, UPDATE_CHECK_URL

# 3. Dependencies
flutter pub get

# 4. Run
flutter run
```

---

## ☁️ Architecture — Joss Ecosystem

```
┌────────────────────┐     JWT      ┌──────────────────┐
│   Estrella Music   │ ──────────► │    Joss Red      │
│  (Flutter Client)  │             │  Identity · Auth  │
│                    │             │  Profile · Backup │
│  Local cache       │             └──────────────────┘
│  Offline playback  │
│  Smart sync queue  │    Music     ┌──────────────────┐
│                    │ ──────────► │     EMusic       │
└────────────────────┘             │  Playlists · Sync │
                                   │  History · Cloud  │
                                   └──────────────────┘
```

- **Joss Red** — source of truth for users, sessions, JWT, profile, friends and backups.
- **EMusic** — specialized music cloud service (library, playlists, favorites, offline metadata, sync).
- **Flutter app** — primary client that works fully offline and syncs when connected.

---

## 📜 License & Authorship

**Copyright © 2026 Joss Estrada (JOSPROX). All rights reserved.**

Licensed under the **[GNU General Public License v3.0](LICENSE)**.

- You may not use modified versions for non-free or commercial purposes.
- You may not publish modified versions on closed-source stores (Google Play, App Store).
- See [CREDITS.md](CREDITS.md) for full third-party acknowledgments.

*This project is not affiliated with, funded, authorized, or endorsed by Google LLC or YouTube. All trademarks belong to their respective owners.*

---

## 🙏 Credits

| Project | Role |
|---|---|
| [Harmony Music](https://github.com/anandnet/Harmony-Music) | Flutter engine foundation |
| [Estrella Music — Kotlin](https://github.com/josprox/Joss-Music) | Original vision & feature set |
| [InnerTune](https://github.com/z-huang/InnerTune) | UI & architecture inspiration |
| [ViMusic](https://github.com/vfsfitvnm/ViMusic) | Functional inspiration |
| [LRCLIB](https://lrclib.net) | Lyrics synchronization |
| [Piped](https://piped.video) | Playlist integration |

---

## 📈 Growth

[![Star History Chart](https://api.star-history.com/svg?repos=josprox/Estrella-Music-v2&type=Date)](https://star-history.com/#josprox/Estrella-Music-v2&Date)

---

<div align="center">

[![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/josprox/Estrella-Music-v2)

Made with ❤️ by **[JOSPROX](https://github.com/josprox)**

</div>
