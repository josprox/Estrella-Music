import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../generated/l10n.dart';

import '../../services/legacy_music_migration_service.dart';
import 'common_dialog_widget.dart';
import 'snackbar.dart';

class LegacyMusicMigrationDialog extends StatelessWidget {
  const LegacyMusicMigrationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LegacyMusicMigrationDialogController());
    return CommonDialog(
      maxWidth: 640,
      child: Container(
        padding: const EdgeInsets.all(20),
        constraints: const BoxConstraints(minHeight: 360),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).settings_migration_title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(
              S.of(context).settings_migration_desc,
            ),
            const SizedBox(height: 14),
            Obx(
              () => controller.errorMessage.value.isEmpty
                  ? const SizedBox.shrink()
                  : Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(controller.errorMessage.value),
                    ),
            ),
            Obx(
              () => controller.isImporting.isTrue
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: LinearProgressIndicator(),
                    )
                  : const SizedBox(height: 8),
            ),
            Obx(
              () => controller.summary.value == null
                  ? const SizedBox.shrink()
                  : Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        controller.summaryText,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: controller.isImporting.isTrue
                        ? null
                        : () => controller.importLegacyData(context),
                    label: Text(S.of(context).migration_btn_select),
                  ),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(S.of(context).close),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LegacyMusicMigrationDialogController extends GetxController {
  final isImporting = false.obs;
  final errorMessage = ''.obs;
  final summary = Rxn<LegacyMigrationSummary>();

  LegacyMusicMigrationService get _migrationService =>
      Get.find<LegacyMusicMigrationService>();

  String get summaryText {
    final currentSummary = summary.value;
    if (currentSummary == null) return '';
    return '${S.current.migration_summary_start(currentSummary.sourceName)}\n'
        '${S.current.migration_summary_playlists(currentSummary.playlistCount)}\n'
        '${S.current.migration_summary_songs(currentSummary.songCount)}\n'
        '${S.current.migration_summary_favorites(currentSummary.favoriteCount)}\n'
        '${S.current.migration_summary_albums(currentSummary.albumCount)}\n'
        '${S.current.migration_summary_artists(currentSummary.artistCount)}';
  }

  Future<void> importLegacyData(BuildContext context) async {
    isImporting.value = true;
    errorMessage.value = '';
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: const ['db', 'backup'],
        dialogTitle: S.current.migration_select_file_dialog,
      );

      if (result == null || result.files.single.path == null) {
        return;
      }

      summary.value =
          await _migrationService.importFromPath(result.files.single.path!);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          snackbar(
            context,
            S.current.migration_success,
            size: SanckBarSize.MEDIUM,
          ),
        );
      }
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Bad state: ', '');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          snackbar(context, errorMessage.value, size: SanckBarSize.BIG),
        );
      }
    } finally {
      isImporting.value = false;
    }
  }
}
