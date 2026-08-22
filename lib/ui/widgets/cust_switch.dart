import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/ui/utils/theme_controller.dart';

class CustSwitch extends StatelessWidget {
  const CustSwitch({super.key, this.onChanged, required this.value});
  final void Function(bool)? onChanged;
  final bool value;

  @override
  Widget build(BuildContext context) {
    final isLightMode =
        Get.find<ThemeController>().themedata.value!.primaryColor ==
            Colors.white;
    final WidgetStateProperty<Icon?> thumbIcon =
        WidgetStateProperty.resolveWith<Icon?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return const Icon(Icons.check, color: Colors.blueAccent);
        }
        return const Icon(Icons.close, color: Colors.grey);
      },
    );

    return Switch(
        thumbIcon: thumbIcon,
        activeThumbColor: Colors.white,
        activeTrackColor: isLightMode ? Colors.grey : null,
        inactiveTrackColor: isLightMode ? Colors.grey : null,
        inactiveThumbColor: isLightMode
            ? Colors.grey[300]
            : Colors.white.withValues(alpha: 0.5),
        value: value,
        onChanged: onChanged);
  }
}
