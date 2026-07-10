import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:harmonymusic/services/auth/auth_service.dart';
import 'package:harmonymusic/services/sync/cloud_migration_service.dart';
import 'package:harmonymusic/services/sync/pending_sync_queue_service.dart';
import 'package:harmonymusic/services/sync/sync_service.dart';
import 'package:harmonymusic/ui/auth/auth_gate.dart';

class CloudSyncStatusDialog extends StatelessWidget {
  const CloudSyncStatusDialog({super.key});

  AuthService get _auth => Get.find<AuthService>();
  SyncService get _sync => Get.find<SyncService>();
  CloudMigrationService get _migration => Get.find<CloudMigrationService>();
  PendingSyncQueueService get _queue => Get.find<PendingSyncQueueService>();

  Future<void> _startMigration(BuildContext context) async {
    if (!_auth.isAuthenticated.value) {
      final prefs = Hive.box('AppPrefs');
      await prefs.put('emusicModeChoiceCompleted', true);
      await prefs.put('emusicCloudRequested', true);
      if (context.mounted) Navigator.of(context).pop();
      Get.offAll(() => const AuthGate());
      return;
    }

    await _sync.enableCloudMode();
  }

  Future<void> _retrySync() async {
    final pushed = await _sync.push();
    if (pushed) {
      await _sync.pull();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final prefs = Hive.box('AppPrefs');
    final mode = prefs.get('emusicDataMode', defaultValue: 'local').toString();
    final migrationStatus = prefs
        .get('cloudMigrationStatus', defaultValue: 'not_started')
        .toString();
    final lastSync =
        prefs.get('lastSuccessfulSyncAt', defaultValue: 'Nunca').toString();

    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: cs.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        mode == 'cloud'
                            ? Icons.cloud_done_rounded
                            : Icons.phone_iphone_rounded,
                        color: cs.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Joss Red / EMusic Cloud',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            mode == 'cloud'
                                ? 'Modo cloud activo'
                                : 'Modo local activo',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                _InfoLine(
                  icon: Icons.sync_rounded,
                  label: 'Estado',
                  value: _sync.lastStatusMessage.value,
                ),
                _InfoLine(
                  icon: Icons.schedule_rounded,
                  label: 'Ultima sincronizacion',
                  value: lastSync,
                ),
                _InfoLine(
                  icon: Icons.pending_actions_rounded,
                  label: 'Cambios pendientes',
                  value: '${_queue.pendingCount.value}',
                ),
                _InfoLine(
                  icon: Icons.move_up_rounded,
                  label: 'Migracion',
                  value: migrationStatus,
                ),
                if (_migration.isMigrating.value) ...[
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: _migration.progress.value.clamp(0, 1),
                    minHeight: 8,
                  ),
                  const SizedBox(height: 8),
                  Text(_migration.statusMessage.value),
                ],
                const SizedBox(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cerrar'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    if (mode == 'cloud')
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: _sync.isSyncing.value ? null : _retrySync,
                          icon: const Icon(Icons.refresh_rounded),
                          label: const Text('Reintentar sync'),
                        ),
                      )
                    else
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: _migration.isMigrating.value
                              ? null
                              : () => _startMigration(context),
                          icon: const Icon(Icons.cloud_upload_rounded),
                          label: const Text('Migrar a cloud'),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: cs.primary, size: 20),
          const SizedBox(width: 12),
          SizedBox(
            width: 132,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: cs.onSurfaceVariant, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }
}
