import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/services/storage/sqlite_store.dart';
import 'package:harmonymusic/generated/l10n.dart';

import 'package:harmonymusic/utils/desktop/app_link_controller.dart' show ProcessLink;
import 'package:harmonymusic/services/music/music_service.dart';

class SearchCategory {
  final String name;
  final Color color;
  final String imageUrl;

  const SearchCategory({
    required this.name,
    required this.color,
    required this.imageUrl,
  });
}

class SearchScreenController extends GetxController with ProcessLink {
  final textInputController = TextEditingController();
  final musicServices = Get.find<MusicServices>();
  final suggestionList = [].obs;
  final historyQuerylist = [].obs;
  late SqliteBox<dynamic> queryBox;
  final urlPasted = false.obs;
  final searchText = ''.obs;

  final categories = [
    SearchCategory(
      name: S.current.genre_pop,
      color: const Color(0xFFFF007F),
      imageUrl: 'https://images.unsplash.com/photo-1514525253361-bee8a187c9bc?q=80&w=250&auto=format&fit=crop',
    ),
    SearchCategory(
      name: S.current.genre_rock,
      color: const Color(0xFF0056D2),
      imageUrl: 'https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?q=80&w=250&auto=format&fit=crop',
    ),
    SearchCategory(
      name: S.current.genre_hiphop,
      color: const Color(0xFFF16E00),
      imageUrl: 'https://images.unsplash.com/photo-1547153760-18fc86324498?q=80&w=250&auto=format&fit=crop',
    ),
    SearchCategory(
      name: S.current.genre_electronic,
      color: const Color(0xFF8A2BE2),
      imageUrl: 'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?q=80&w=250&auto=format&fit=crop',
    ),
    SearchCategory(
      name: S.current.genre_jazz,
      color: const Color(0xFFD4AF37),
      imageUrl: 'https://images.unsplash.com/photo-1511192336575-5a79af67a629?q=80&w=250&auto=format&fit=crop',
    ),
    SearchCategory(
      name: S.current.genre_latin,
      color: const Color(0xFF008080),
      imageUrl: 'https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?q=80&w=250&auto=format&fit=crop',
    ),
    const SearchCategory(
      name: "Podcasts",
      color: Color(0xFFE91E63),
      imageUrl: 'https://images.unsplash.com/photo-1590602847861-f357a9332bbc?q=80&w=250&auto=format&fit=crop',
    ),
  ];

  // Desktop search bar related
  final focusNode = FocusNode();
  final isSearchBarInFocus = false.obs;

  @override
  onInit() {
    _init();
    super.onInit();
    // BloomeeTunes Debounce logic para sugerencias
    debounce(searchText, (String text) async {
      if (text.isEmpty || text.contains("https://")) {
        suggestionList.clear();
        return;
      }
      final results = await musicServices.getSearchSuggestion(text);
      suggestionList.value = results;
    }, time: const Duration(milliseconds: 300));
  }

  _init() async {
    if(GetPlatform.isDesktop){
      focusNode.addListener((){
        isSearchBarInFocus.value = focusNode.hasFocus;
      });
    }
    queryBox = await SqliteStore.openBox("searchQuery");
    historyQuerylist.value = queryBox.values.toList().reversed.toList();
  }

  void onChanged(String text) {
    searchText.value = text;
    if(text.contains("https://")){
      urlPasted.value = true; 
      return;
    }
    urlPasted.value = false;
  }

  // Lógica de combinación: filtra historial local que coincida y añade sugerencias de API
  List<String> get filteredHistory {
    final query = searchText.value.trim().toLowerCase();
    if (query.isEmpty) return historyQuerylist.take(8).cast<String>().toList();
    return historyQuerylist
        .where((q) => q.toString().toLowerCase().contains(query))
        .take(5)
        .cast<String>()
        .toList();
  }

  List<String> get apiSuggestions {
    final historySet = filteredHistory.map((e) => e.toLowerCase()).toSet();
    return suggestionList
        .cast<String>()
        .where((q) => !historySet.contains(q.toLowerCase()))
        .toList();
  }

  Future<void> suggestionInput(String txt) async {
    textInputController.text = txt;
    textInputController.selection =
        TextSelection.collapsed(offset: textInputController.text.length);
    onChanged(txt);
  }

  Future<void> addToHistryQueryList(String txt) async {
    final cleanTxt = txt.trim();
    if (cleanTxt.isEmpty) return;

    if (historyQuerylist.length > 9) {
      final queryForRemoval = queryBox.getAt(0);
      await queryBox.deleteAt(0);
      historyQuerylist.removeWhere((element) => element == queryForRemoval);
    }
    if (!historyQuerylist.contains(cleanTxt)) {
      await queryBox.add(cleanTxt);
      historyQuerylist.insert(0, cleanTxt);
    }

    //reset current query and suggestionlist
    reset();
  }

  void reset() {
    urlPasted.value = false;
    searchText.value = "";
    textInputController.text = "";
    suggestionList.clear();
  }

  Future<void> removeQueryFromHistory(String txt) async {
    final index = queryBox.values.toList().indexOf(txt);
    if (index != -1) {
      await queryBox.deleteAt(index);
      historyQuerylist.remove(txt);
    }
  }

  @override
  void dispose() {
    focusNode.dispose();
    textInputController.dispose();
    queryBox.close();
    super.dispose();
  }
}
