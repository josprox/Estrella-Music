<div align="center">

<img src="cover.png" width="800" alt="Estrella Music v2 Cover">

# Estrella Music v2
**The Modern Flutter Evolution of Music Streaming**

</div>

---

## 🌟 What is Estrella Music v2?

**Estrella Music v2** is a high-performance, cross-platform music streaming application built using Flutter. This version represents a powerful fusion between the robust engine of [Harmony Music](https://github.com/anandnet/Harmony-Music) and the feature-rich legacy of the original [Estrella Music Kotlin project](https://github.com/josprox/Joss-Music).

By combining the best of both worlds, we've created an experience that is faster, more beautiful, and tightly integrated with the YouTube Music ecosystem, while maintaining full compatibility with your existing music library.

---

## 🚀 Key Features

- **🎵 Unlimited Streaming**: Access millions of songs, albums, and playlists from YouTube Music.
- **🔄 Legacy Migration**: Easily import your playlists, favorites, and history from the original Estrella Music (Kotlin) project using `song.db` or `.backup` files.
- **📱 Immersive Material 3 UI**: A sleek, modern design with dynamic themes that adapt to your album art and system preferences.
- **🛠 Premium Update System**: Integrated blocking update gate with a world-class UI to ensure you're always on the latest, most stable version.
- **🔊 Advanced Playback**:
  - High-quality audio engine with caching for offline listening.
  - Radio feature support for continuous discovering.
  - Gapless playback and skip silence support.
  - Background playback with native media controls.
- **📜 Lyrics Support**: Both synced (LRC) and plain text lyrics support via LRCLIB.
- **🚗 Navigation & Desktop**: Support for **Android Auto**, Windows, and Linux.
- **☁️ Cloud & Local Backups**: Secure your data with automated cloud backups via OneSignal and manual local exports.
- **🚫 Ad-Free Experience**: No advertisements, ever.

---

## 🛠 Tech Stack

- **Core**: [Flutter](https://flutter.dev) (Dart)
- **State Management**: [GetX](https://pub.dev/packages/get)
- **Audio Engine**: `just_audio` (Android), `media_kit` (Windows/Linux)
- **Networking**: [Dio](https://pub.dev/packages/dio) & [YouTube Explode](https://pub.dev/packages/youtube_explode_dart)
- **Database**: SQLite (`sqlite3`) with transactional legacy-Hive migration
- **Notifications**: [OneSignal](https://pub.dev/packages/onesignal_flutter)

---

## 📥 Installation & Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/josprox/Estrella-Music-v2.git
   ```
2. **Setup environment**:
   Create a `.env` file based on `.env.example` and add your `API_URL`, `ONESIGNAL_APP_ID`, and `UPDATE_CHECK_URL`.
3. **Install dependencies**:
   ```bash
   flutter pub get
   ```
4. **Run the app**:
   ```bash
   flutter run
   ```

### 🍏 Instalación en iPhone / iOS (Re-firma Automática)

Para instalar el archivo `Estrella Music.ipa` en tu iPhone y hacer que la firma no expire a los 7 días (evitando usar la computadora cada semana):

1. **Instalar SideStore**: Realiza la instalación inicial de **SideStore** en tu iPhone siguiendo la guía de [sidestore.io](https://sidestore.io) (requiere ordenador para la carga inicial y configurar la VPN interna de WireGuard).
2. **Configurar el servidor de firmas Anisette**:
   - Abre la app de **SideStore** en tu iPhone.
   - Ve a **Settings** (Ajustes).
   - Busca el campo **Anisette Server URL** y reemplázalo por tu propio servidor unificado de EMusic:
     `https://emusic.joss.red/api/anisette`
   - Inicia sesión con tu Apple ID dentro de SideStore.
3. **Instalar la App**:
   - Descarga el archivo `Estrella Music.ipa` en tu iPhone y guárdalo en la aplicación **Archivos**.
   - En **SideStore**, ve a **My Apps**, pulsa el botón **`+`** de arriba a la izquierda y selecciona el archivo `.ipa`.
4. **Renovación automática**: Siempre que estés en Wi-Fi, abre SideStore una vez a la semana y las firmas se renovarán en segundo plano de forma transparente.

---

## 📜 License & Authorship

**Estrella Music v2** is developed and maintained by **Joss Estrada (JOSPROX)**.

- **Copyright © 2026 Joss Estrada (JOSPROX)**. All rights reserved.
- This software is licensed under the **GNU General Public License v3.0**.
- For detailed acknowledgments, please refer to the [CREDITS.md](CREDITS.md) file.

---

## 🙏 Credits & Acknowledgments

This project is built upon the incredible work of the open-source community:

- [**Harmony Music**](https://github.com/anandnet/Harmony-Music): The foundational Flutter engine for this version.
- [**Estrella Music (Kotlin)**](https://github.com/josprox/Joss-Music): The original vision and feature set.
- [**InnerTune**](https://github.com/z-huang/InnerTune) & [**ViMusic**](https://github.com/vfsfitvnm/ViMusic): Major UI and functional inspirations.
- [**LRCLIB**](https://lrclib.net): Lyrics synchronization.
- [**Piped**](https://piped.video): Playlist integration.

---

## ⚠️ Disclaimer & License

**Estrella Music v2** is a free software licensed under **GPL v3.0**. 

- Copied/Modified versions of this software cannot be used for 'non-free' or profit purposes.
- You cannot publish modified versions of this app on closed-source repositories such as Google Play Store or Apple App Store.

*This project is not affiliated with, funded, authorized, or endorsed by Google LLC or YouTube. All trademarks are the property of their respective owners.*
