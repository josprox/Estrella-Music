import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/ui/screens/Search/search_result_screen_v2.dart';
import 'search_result_screen_controller.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SearchResultScreenController());
    return const SearchResultScreenBN();
  }
}
