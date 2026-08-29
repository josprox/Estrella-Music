import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:estrella_music/models/album.dart';
import 'package:estrella_music/models/artist.dart';

import 'package:estrella_music/ui/screens/Artists/artist_screen.dart';
import 'package:estrella_music/ui/screens/Home/home_screen.dart';
import 'package:estrella_music/ui/screens/Home/home_screen_controller.dart';

import 'screens/Album/album_screen.dart';
import 'screens/Playlist/playlist_screen.dart';
import 'screens/Artists/artist_content_list_screen.dart';
import 'screens/Search/search_result_screen.dart';
import 'screens/Search/search_screen.dart';

class ScreenNavigationSetup {
  ScreenNavigationSetup._();

  static const id = 1;
  static const homeScreen = '/homeScreen';
  static const searchScreen = '/searchScreen';
  static const searchResultScreen = '/searchResultScreen';
  static const artistScreen = '/artistScreen';
  static const artistContentListScreen = '/artistContentListScreen';
  static const albumScreen = '/albumScreen';
  static const playlistScreen = '/playlistScreen';
}

class ScreenNavigationObserver extends NavigatorObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _updateNavbar();
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _updateNavbar();
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    _updateNavbar();
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _updateNavbar();
  }

  void _updateNavbar() {
    try {
      if (Get.isRegistered<HomeScreenController>()) {
        Get.find<HomeScreenController>().whenHomeScreenOnTop();
      }
    } catch (_) {}
  }
}

class ScreenNavigation extends StatelessWidget {
  const ScreenNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: Get.nestedKey(ScreenNavigationSetup.id),
        initialRoute: '/homeScreen',
        observers: [ScreenNavigationObserver()],
        onGenerateRoute: (settings) {
          Get.routing.args = settings.arguments;
          switch (settings.name) {
            case ScreenNavigationSetup.homeScreen:
              return GetPageRoute(
                  page: () => const HomeScreen(), settings: settings);

            case ScreenNavigationSetup.albumScreen:
              final id = (settings.arguments as (Album?, String)).$2;
              return GetPageRoute(
                  page: () => AlbumScreen(
                        key: Key(id),
                      ),
                  settings: settings);

            case ScreenNavigationSetup.playlistScreen:
              final id = (settings.arguments as List)[1] as String;
              return GetPageRoute(
                  page: () => PlaylistScreen(
                        key: Key(id),
                      ),
                  settings: settings);

            case ScreenNavigationSetup.searchScreen:
              return GetPageRoute(
                  page: () => const SearchScreen(), settings: settings);

            case ScreenNavigationSetup.searchResultScreen:
              return GetPageRoute(
                  page: () => const SearchResultScreen(), settings: settings);

            case ScreenNavigationSetup.artistScreen:
              final args = settings.arguments as List;
              final id = args[0] ? args[1] : (args[1] as Artist).browseId;
              return GetPageRoute(
                  page: () => ArtistScreen(
                        key: Key(id),
                      ),
                  settings: settings);

            case ScreenNavigationSetup.artistContentListScreen:
              return GetPageRoute(
                  page: () => const ArtistContentListScreen(),
                  settings: settings);

            default:
              return null;
          }
        });
  }
}
