import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/ui/widgets/loader.dart';
import 'package:harmonymusic/ui/widgets/search_related_widgets.dart';

import 'package:harmonymusic/ui/navigator.dart';
import 'search_result_screen_controller.dart';
import 'package:harmonymusic/ui/widgets/nebula_background.dart';
import 'package:harmonymusic/generated/l10n.dart';
import 'package:harmonymusic/utils/localization/l10n_extensions.dart';

class SearchResultScreenBN extends StatelessWidget {
  const SearchResultScreenBN({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchResultScreenController searchResScrController =
        Get.find<SearchResultScreenController>();
    final topPadding = context.isLandscape ? 50.0 : 80.0;
    
    return Scaffold(

      body: Stack(
        children: [
          NebulaBackground(seedString: searchResScrController.queryString),
          Padding(
            padding: EdgeInsets.only(top: topPadding),
            child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 55,
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        Get.nestedKey(ScreenNavigationSetup.id)!
                            .currentState!
                            .pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios_new),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          S.current.searchRes,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Obx(
                          () => Text(
                            "${S.current.for1} \"${searchResScrController.queryString.value}\"",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            
            // Filter Chips (BloomeeTunes style)
            Obx(() {
              if (searchResScrController.filters.isEmpty) return const SizedBox.shrink();
              return SizedBox(
                height: 40,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: searchResScrController.filters.length,
                  itemBuilder: (context, index) {
                    final filterName = searchResScrController.filters[index];
                    final isSelected = searchResScrController.currentFilter.value == filterName;
                    
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ActionChip(
                        backgroundColor: isSelected 
                            ? Theme.of(context).colorScheme.primary 
                            : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.08),
                        side: BorderSide(
                          color: isSelected 
                              ? Theme.of(context).colorScheme.primary 
                              : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelStyle: TextStyle(
                          color: isSelected 
                              ? Theme.of(context).colorScheme.onPrimary 
                              : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          fontSize: 13,
                        ),
                        label: Text(
                          filterName == 'All' ? S.current.results : filterName.toLowerCase().removeAllWhitespace.t,
                        ),
                        onPressed: () => searchResScrController.applyFilter(filterName),
                      ),
                    );
                  },
                ),
              );
            }),
            const SizedBox(height: 10),
            
            // Main Content Area
            Expanded(
              child: Obx(() {
                if (searchResScrController.isResultContentFetced.isTrue &&
                    searchResScrController.filters.length <= 1) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.current.nomatch,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text("'${searchResScrController.queryString.value}'"),
                      ],
                    ),
                  );
                } else if (searchResScrController.isResultContentFetced.isTrue) {
                  return const ResultWidget(isv2Used: true);
                } else {
                  return const Center(child: LoadingIndicator());
                }
              }),
            )
          ],
        ),
      ),
    ],
   ),
  );
 }
}
