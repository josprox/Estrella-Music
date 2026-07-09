import 'package:flutter/material.dart';

import 'widgets/animated_auth_background.dart';

class CloudModeChoiceScreen extends StatelessWidget {
  const CloudModeChoiceScreen({
    super.key,
    required this.onKeepLocal,
    required this.onChooseCloud,
  });

  final VoidCallback onKeepLocal;
  final VoidCallback onChooseCloud;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const AnimatedAuthBackground(),
          Container(color: Colors.black.withValues(alpha: 0.3)),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 980),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.graphic_eq_rounded,
                        color: Colors.white,
                        size: 72,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Elige como quieres usar Estrella Music',
                        style: theme.textTheme.displaySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          height: 1.05,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Puedes mantener todo en este dispositivo o migrar tu biblioteca a Joss Red para sincronizarla como un ecosistema cloud.',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.76),
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 32),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final isWide = constraints.maxWidth >= 760;
                          final localCard = _ModeCard(
                            icon: Icons.phone_android_rounded,
                            title: 'Mantener local',
                            subtitle:
                                'Tus canciones, playlists, favoritos e historial se quedan solo en este dispositivo.',
                            bullets: const [
                              'No necesitas iniciar sesion.',
                              'La app funciona como ahora.',
                              'Puedes migrar a cloud despues.',
                            ],
                            buttonLabel: 'Usar solo este dispositivo',
                            onPressed: onKeepLocal,
                            accent: const Color(0xFF2EC4B6),
                          );
                          final cloudCard = _ModeCard(
                            icon: Icons.cloud_sync_rounded,
                            title: 'Migrar a Joss Red',
                            subtitle:
                                'EMusic Cloud sera la fuente principal y el dispositivo funcionara como cache offline.',
                            bullets: const [
                              'Requiere tu cuenta de Joss Red.',
                              'Crea respaldo local antes de subir.',
                              'Sincroniza cambios al volver internet.',
                            ],
                            buttonLabel: 'Migrar y sincronizar',
                            onPressed: onChooseCloud,
                            accent: const Color(0xFFFF9F1C),
                            primary: true,
                          );
                          if (isWide) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: localCard),
                                const SizedBox(width: 18),
                                Expanded(child: cloudCard),
                              ],
                            );
                          }
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              localCard,
                              const SizedBox(height: 16),
                              cloudCard,
                            ],
                          );
                        },
                      ),
                    ],
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

class _ModeCard extends StatelessWidget {
  const _ModeCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.bullets,
    required this.buttonLabel,
    required this.onPressed,
    required this.accent,
    this.primary = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final List<String> bullets;
  final String buttonLabel;
  final VoidCallback onPressed;
  final Color accent;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF08131C).withValues(alpha: 0.86),
        borderRadius: BorderRadius.circular(8),
        border:
            Border.all(color: accent.withValues(alpha: primary ? 0.5 : 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 28,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: accent, size: 30),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.72),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 20),
          ...bullets.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle_rounded, color: accent, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.78),
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton.icon(
              onPressed: onPressed,
              icon: Icon(primary
                  ? Icons.cloud_upload_rounded
                  : Icons.phone_iphone_rounded),
              label: Text(buttonLabel),
              style: FilledButton.styleFrom(
                backgroundColor: primary ? accent : Colors.white,
                foregroundColor:
                    primary ? const Color(0xFF191327) : const Color(0xFF102534),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
