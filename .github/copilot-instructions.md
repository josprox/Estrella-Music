# Copilot Instructions for Estrella Music v2

## Project Overview

Estrella Music v2 is a cross-platform music streaming and local player application built with Flutter, supporting Android, Windows, Linux, macOS, and iOS. The app operates around a modular `MusicProvider` architecture (featuring `LocalMusicProvider` for offline media and `EMusicProvider` for cloud streaming with Joss Red authentication).

## Technology Stack

- **Framework**: Flutter 3.24.2+ (Dart SDK >=3.1.5 <4.0.0)
- **Architecture**: Modular `MusicProvider` and `ProfileManager`
- **State Management**: GetX (get: ^4.7.1)
- **Audio Playback**:
  - Android/iOS: just_audio (^0.9.46)
  - Linux/Windows: media_kit via just_audio_media_kit
  - Background audio: audio_service (^0.18.17)
- **Local Storage**: Hive (^2.2.3) for local profiles, SQLite (`sqlite3`) for EMusic sync/outbox
- **Authentication**: Joss Red (JWT global session)
- **Cloud Music**: EMusic server
- **HTTP Client**: dio (^5.7.0)
- **UI Components**: animations, cached_network_image, flutter_slidable, shimmer

## Project Structure

```
lib/
├── base_class/      # Base classes and abstractions
├── mixins/          # Reusable mixins
├── models/          # Data models
├── music_provider/  # MusicProvider contract, LocalMusicProvider, EMusicProvider
├── profiles/        # ProfileManager and profile state isolation
├── services/        # Business logic services (audio, music catalog, sync, downloader)
├── ui/              # User interface
│   ├── player/      # Music player UI and controllers
│   ├── screens/     # App screens (Home, Library, Settings, Search, Auth)
│   ├── utils/       # UI utilities (theme controller)
│   └── widgets/     # Reusable widgets
└── utils/           # General utilities and helpers
```

## Key Controllers & Services (GetX)

- `PlayerController` - Manages music playback
- `MusicCatalogService` - Neutral catalog interface for active provider
- `ProfileManager` - Manages active musical profiles and isolated contexts
- `MusicProviderManager` - Manages and resolves provider instances
- `SyncService` - Syncs cloud data when provider/profile is authorized
- `LibraryController` - Library/collection management
- `SettingsScreenController` - App settings
- `SearchScreenController` - Search functionality
- `ThemeController` - Dynamic theming

## Architecture Patterns

- **MusicProvider Contract**: UI depends strictly on neutral contracts, never on concrete providers
- **Profile Isolation**: Favorites, playlists, history, and downloads are namespaced per `profileId`
- **State Management**: GetX pattern with controllers
- **Dependency Injection**: GetX dependency injection (`Get.put`, `Get.find`)
- **Offline First**: `LocalMusicProvider` is always available as fallback

## Important Considerations

1. **Joss Red Authentication**: Global login is required before entering the application.
2. **Local Privacy**: Local files and downloads are strictly stored locally in Hive and never synced to cloud.
3. **Neutral UI**: No provider-specific conditionals in UI widgets. Use `capabilities`.
4. **Third Party Content**: Be mindful of copyright and content usage
5. **Cross-Platform**: Changes should consider all target platforms (Android, Windows, Linux)
6. **Offline Support**: App caches songs and supports offline playback
7. **Background Playback**: Audio service integration for background music

## Common Tasks

### Adding a New Screen
1. Create screen file in `lib/ui/screens/[ScreenName]/`
2. Create corresponding controller extending `GetxController`
3. Register controller with GetX
4. Add navigation route if needed

### Adding a New Feature
1. Consider platform support (mobile vs desktop)
2. Update relevant services if needed
3. Create/update models as needed
4. Update UI components
5. Test on target platforms

### Modifying Audio Playback
- Audio logic is in `services/audio_handler.dart`
- Player UI in `ui/player/`
- Platform-specific implementations via just_audio or media_kit

## CI/CD

- Linting and build checks run on PRs via `.github/workflows/code_quality.yml`
- APK builds are automated
- Windows executable builds have separate workflow

## Testing

- Widget tests are in `test/` directory
- Follow existing test patterns when adding new tests
- Use Flutter's widget testing framework

## Additional Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [GetX Documentation](https://pub.dev/packages/get)
- [Hive Documentation](https://docs.hivedb.dev/)
- Project README.md for feature list and credits
