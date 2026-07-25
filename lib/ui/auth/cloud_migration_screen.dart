import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:harmonymusic/services/sync/cloud_migration_service.dart';
import 'package:harmonymusic/services/sync/cloud_sync_manager.dart';
import 'package:harmonymusic/services/sync/sync_service.dart';
import 'package:harmonymusic/ui/home.dart';
import 'widgets/animated_auth_background.dart';

class CloudMigrationScreen extends StatefulWidget {
  const CloudMigrationScreen({super.key});

  @override
  State<CloudMigrationScreen> createState() => _CloudMigrationScreenState();
}

class _CloudMigrationScreenState extends State<CloudMigrationScreen> {
  bool _started = false;

  CloudMigrationService get migration => Get.find<CloudMigrationService>();
  SyncService get sync => Get.find<SyncService>();
  CloudSyncManager get cloudSyncManager => Get.find<CloudSyncManager>();

  Future<void> _start() async {
    if (_started) return;
    setState(() => _started = true);
    final result = await cloudSyncManager.switchMode(DataMode.cloud);
    if (!mounted) return;
    if (result.isSuccess) {
      Get.offAll(() => const Home());
    } else {
      setState(() => _started = false);
    }
  }

  Future<void> _cancel() async {
    await migration.cancelLastMigration();
    await cloudSyncManager.switchMode(DataMode.local);
    if (!mounted) return;
    Get.offAll(() => const Home());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const AnimatedAuthBackground(),
          Container(color: Colors.black.withValues(alpha: 0.32)),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 620),
                  child: Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: const Color(0xFF08131C).withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Obx(
                      () => Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 62,
                            height: 62,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF9F1C)
                                  .withValues(alpha: 0.14),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.cloud_sync_rounded,
                              color: Color(0xFFFFB545),
                              size: 34,
                            ),
                          ),
                          const SizedBox(height: 22),
                          Text(
                            'Migrar biblioteca a Joss Red',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            migration.statusMessage.value,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.78),
                              height: 1.45,
                            ),
                          ),
                          if (migration.lastError.value.isNotEmpty) ...[
                            const SizedBox(height: 12),
                            Text(
                              migration.lastError.value,
                              style: const TextStyle(
                                color: Color(0xFFFF6B6B),
                                height: 1.35,
                              ),
                            ),
                          ],
                          const SizedBox(height: 24),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(99),
                            child: LinearProgressIndicator(
                              value: migration.isMigrating.value
                                  ? migration.progress.value.clamp(0, 1)
                                  : null,
                              minHeight: 9,
                              backgroundColor:
                                  Colors.white.withValues(alpha: 0.12),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFF2EC4B6),
                              ),
                            ),
                          ),
                          const SizedBox(height: 22),
                          const _StepRow(
                            icon: Icons.security_rounded,
                            text: 'Primero se crea un respaldo local.',
                          ),
                          const _StepRow(
                            icon: Icons.upload_rounded,
                            text: 'La biblioteca se sube por partes.',
                          ),
                          const _StepRow(
                            icon: Icons.verified_rounded,
                            text:
                                'Cloud se activa solo si EMusic valida los datos.',
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: migration.isMigrating.value
                                      ? null
                                      : _cancel,
                                  icon: const Icon(Icons.close_rounded),
                                  label: const Text('Seguir local'),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    side: BorderSide(
                                      color:
                                          Colors.white.withValues(alpha: 0.24),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: FilledButton.icon(
                                  onPressed: migration.isMigrating.value
                                      ? null
                                      : _start,
                                  icon: const Icon(Icons.cloud_upload_rounded),
                                  label: Text(_started
                                      ? 'Migrando...'
                                      : 'Iniciar migracion'),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: const Color(0xFFFF9F1C),
                                    foregroundColor: const Color(0xFF191327),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  const _StepRow({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF2EC4B6), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.74),
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
