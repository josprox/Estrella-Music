import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/ui/screens/Search/search_screen_controller.dart';

import '../../../navigator.dart';

class SearchItem extends StatelessWidget {
  final String queryString;
  final bool isHistoryString;
  const SearchItem(
      {super.key, required this.queryString, required this.isHistoryString});
  @override
  Widget build(BuildContext context) {
    final searchScreenController = Get.find<SearchScreenController>();
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        hoverColor: cs.primary.withValues(alpha: 0.08),
        splashColor: cs.primary.withValues(alpha: 0.12),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        onTap: () {
          Get.toNamed(ScreenNavigationSetup.searchResultScreen,
              id: ScreenNavigationSetup.id, arguments: queryString);
          searchScreenController.addToHistryQueryList(queryString);
          // for Desktop searchbar
          if (GetPlatform.isDesktop) {
            searchScreenController.focusNode.unfocus();
          }
        },
        leading: isHistoryString
            ? const Icon(Icons.history)
            : const Icon(Icons.search),
        minLeadingWidth: 20,
        dense: true,
        title: Text(
          queryString,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        ),
        trailing: SizedBox(
          width: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (isHistoryString)
                IconButton(
                  iconSize: 18,
                  splashRadius: 18,
                  visualDensity: const VisualDensity(horizontal: -2),
                  onPressed: () {
                    searchScreenController
                        .removeQueryFromHistory(queryString);
                  },
                  icon: Icon(
                    Icons.clear,
                    color: Theme.of(context).textTheme.titleMedium!.color?.withValues(alpha: 0.7),
                  ),
                )
              else
                const SizedBox(
                  width: 40,
                ),
              IconButton(
                iconSize: 20,
                splashRadius: 18,
                visualDensity: const VisualDensity(horizontal: -2),
                onPressed: () {
                  searchScreenController.suggestionInput(queryString);
                },
                icon: Icon(
                  Icons.north_west,
                  color: Theme.of(context).textTheme.titleMedium!.color?.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
