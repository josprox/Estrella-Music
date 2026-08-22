import 'package:material_ui/material_ui.dart';

class PlaylistAlbumScrollBehaviour extends MaterialScrollBehavior {
   @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
