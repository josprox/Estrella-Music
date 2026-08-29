import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restart_app/restart_app.dart';
import 'package:estrella_music/generated/l10n.dart';

import 'package:estrella_music/services/backup/app_backup_service.dart';
import 'package:estrella_music/services/auth/auth_service.dart';
import 'package:estrella_music/services/backup/cloud_backup_service.dart';
import 'common_dialog_widget.dart';
import 'snackbar.dart';

class CloudBackupDialog extends StatelessWidget {
  const CloudBackupDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CloudBackupDialogController());
    return CommonDialog(
      maxWidth: 700,
      child: Container(
        height: 520,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).settings_cloud_backup,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              S.of(context).settings_cloud_backup_dialog_desc,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Obx(
              () => controller.errorMessage.value.isEmpty
                  ? const SizedBox.shrink()
                  : Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(controller.errorMessage.value),
                    ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Obx(
                  () => controller.isRestored.isTrue
                      ? Expanded(
                          child: ElevatedButton.icon(
                            onPressed: controller.restartApp,
                            icon: const Icon(Icons.restart_alt),
                            label: Text(S.of(context).backup_btn_restart),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                const Spacer(),
                IconButton(
                  onPressed: controller.refreshBackups,
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Obx(
              () => controller.isBusy.isTrue
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: LinearProgressIndicator(),
                    )
                  : const SizedBox(height: 4),
            ),
            Obx(
              () => controller.isRestored.isTrue
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        S.of(context).backup_restore_success,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            Expanded(
              child: Obx(() {
                if (controller.backups.isEmpty) {
                  return Center(
                    child: Text(S.of(context).backup_no_backups),
                  );
                }

                return ListView.separated(
                  itemCount: controller.backups.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final backup = controller.backups[index];
                    return ListTile(
                      title: Text(
                        backup.fileName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(controller.formatBackupDate(backup)),
                      trailing: Wrap(
                        spacing: 4,
                        children: [
                          IconButton(
                            tooltip: S.of(context).restore,
                            onPressed: controller.isBusy.isTrue
                                ? null
                                : () =>
                                    controller.restoreBackup(context, backup),
                            icon: const Icon(Icons.cloud_download_outlined),
                          ),
                          IconButton(
                            tooltip: S.of(context).delete,
                            onPressed: controller.isBusy.isTrue
                                ? null
                                : () =>
                                    controller.deleteBackup(context, backup),
                            icon: const Icon(Icons.delete_outline),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class CloudBackupDialogController extends GetxController {
  final backups = <CloudBackupFile>[].obs;
  final isBusy = false.obs;
  final isRestored = false.obs;
  final errorMessage = ''.obs;

  CloudBackupService get _cloudBackupService => Get.find<CloudBackupService>();
  AppBackupService get _appBackupService => Get.find<AppBackupService>();
  AuthService get _authService => Get.find<AuthService>();

  @override
  void onInit() {
    refreshBackups();
    super.onInit();
  }

  Future<void> refreshBackups() async {
    if (!_authService.isAuthenticated.value) {
      errorMessage.value = S.current.backup_auth_required;
      backups.clear();
      return;
    }

    errorMessage.value = '';
    try {
      backups.value = await _cloudBackupService.listBackups();
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Bad state: ', '');
    }
  }

  Future<void> uploadBackup(BuildContext context) async {
    isBusy.value = true;
    errorMessage.value = '';
    try {
      final bytes = await _appBackupService.createBackupBytes();
      final timestamp = DateTime.now()
          .toIso8601String()
          .replaceAll(':', '')
          .replaceAll('.', '_');
      await _cloudBackupService.uploadBackupBytes(
        bytes: bytes,
        fileName: 'estrellamusic_$timestamp.hmb',
      );
      await refreshBackups();
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        snackbar(
          context,
          S.current.backup_upload_success,
          size: SanckBarSize.MEDIUM,
        ),
      );
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Bad state: ', '');
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        snackbar(context, errorMessage.value, size: SanckBarSize.BIG),
      );
    } finally {
      isBusy.value = false;
    }
  }

  Future<void> restoreBackup(
    BuildContext context,
    CloudBackupFile backup,
  ) async {
    isBusy.value = true;
    errorMessage.value = '';
    try {
      final bytes = await _cloudBackupService.downloadBackupBytes(backup);
      await _appBackupService.restoreBackupBytes(bytes);
      isRestored.value = true;
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        snackbar(
          context,
          S.current.backup_restore_success,
          size: SanckBarSize.MEDIUM,
        ),
      );
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Bad state: ', '');
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        snackbar(context, errorMessage.value, size: SanckBarSize.BIG),
      );
    } finally {
      isBusy.value = false;
    }
  }

  Future<void> deleteBackup(
    BuildContext context,
    CloudBackupFile backup,
  ) async {
    isBusy.value = true;
    errorMessage.value = '';
    try {
      await _cloudBackupService.deleteBackup(backup);
      await refreshBackups();
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        snackbar(context, S.current.backup_delete_success,
            size: SanckBarSize.MEDIUM),
      );
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Bad state: ', '');
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        snackbar(context, errorMessage.value, size: SanckBarSize.BIG),
      );
    } finally {
      isBusy.value = false;
    }
  }

  Future<void> restartApp() async {
    final result = await Restart.restartApp(
      mode: GetPlatform.isAndroid
          ? RestartMode.process
          : RestartMode.platformDefault,
      forceKill: GetPlatform.isAndroid,
    );

    if (!result.success) {
      errorMessage.value =
          result.message ?? result.code ?? 'No fue posible reiniciar la app.';
      if (!GetPlatform.isAndroid) {
        exit(0);
      }
    }
  }

  String formatBackupDate(CloudBackupFile backup) {
    final date = backup.createdAtDate;
    if (date == null) {
      return 'Sin fecha visible';
    }
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
