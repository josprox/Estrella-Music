import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harmonymusic/generated/l10n.dart';
import 'update_controller.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({super.key});

  static const Color accentColor = Color(0xFFFF719A);
  static const Color backgroundColor = Color(0xFF0F0F12);
  static const Color cardColor = Color(0xFF1A1A1E);
  static const Color successColor = Color(0xFF4CAF7D);
  static const Color errorColor = Color(0xFFFF5252);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateController());
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Obx(() {
        if (controller.isLoading.isTrue) {
          return const Center(
            child: CircularProgressIndicator(color: accentColor),
          );
        }

        if (controller.error.isNotEmpty) {
          return _buildFetchErrorState(context, controller);
        }

        final data = controller.updateInfo.value;
        if (data == null) {
          return Center(
            child: Text(
              S.of(context).infoNotAvailable,
              style: const TextStyle(color: Colors.white),
            ),
          );
        }

        return SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 60.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ── Ícono de plataforma ───────────────────────
                      _PlatformIconWidget(
                        downloadState: controller.downloadState.value,
                      ),
                      const SizedBox(height: 32),

                      // ── Título ────────────────────────────────────
                      Text(
                        data['Titulo'] ?? 'Nueva Versión',
                        style: GoogleFonts.manrope(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: -1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),

                      // ── Píldora de versión ────────────────────────
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white12),
                        ),
                        child: Text(
                          data['Version'] ?? 'V-?',
                          style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.blueAccent.shade100,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ── Etiqueta de archivo a descargar ───────────
                      if (GetPlatform.isAndroid || GetPlatform.isWindows)
                        _FileNameChip(fileName: controller.platformFileName),

                      const SizedBox(height: 28),

                      // ── Markdown con notas de versión ─────────────
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: MarkdownBody(
                          data: data['Descripcion'] ?? '',
                          styleSheet:
                              MarkdownStyleSheet.fromTheme(theme).copyWith(
                            p: GoogleFonts.manrope(
                              fontSize: 15,
                              color: Colors.white70,
                              height: 1.5,
                            ),
                            h1: GoogleFonts.manrope(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            h2: GoogleFonts.manrope(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            listBullet: const TextStyle(color: accentColor),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),

              // ── Área inferior con progreso + botón ─────────────
              _BottomActionArea(controller: controller),
            ],
          ),
        );
      }),
    );
  }

  // ──────────────────────────────────────────────
  // Estado de error al cargar info
  // ──────────────────────────────────────────────

  Widget _buildFetchErrorState(
    BuildContext context,
    UpdateController controller,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 60,
              color: errorColor,
            ),
            const SizedBox(height: 24),
            Text(
              S.of(context).loadInfoUpdate,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              controller.error.value,
              style: const TextStyle(fontSize: 12, color: Colors.white54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: controller.fetchUpdateInfo,
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              child: Text(
                S.of(context).retry,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════
// Widget: ícono animado según plataforma / estado
// ══════════════════════════════════════════════════════

class _PlatformIconWidget extends StatelessWidget {
  const _PlatformIconWidget({required this.downloadState});

  final DownloadState downloadState;

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color iconColor = UpdateScreen.accentColor;

    if (downloadState == DownloadState.done) {
      icon = Icons.check_circle_rounded;
      iconColor = UpdateScreen.successColor;
    } else if (downloadState == DownloadState.error) {
      icon = Icons.error_rounded;
      iconColor = UpdateScreen.errorColor;
    } else if (downloadState == DownloadState.installing) {
      icon = Icons.install_mobile_rounded;
    } else if (GetPlatform.isAndroid) {
      icon = Icons.smartphone_rounded;
    } else if (GetPlatform.isWindows) {
      icon = Icons.laptop_windows_rounded;
    } else if (GetPlatform.isLinux) {
      icon = Icons.computer_rounded;
    } else if (GetPlatform.isMacOS) {
      icon = Icons.desktop_mac_rounded;
    } else if (GetPlatform.isIOS) {
      icon = Icons.phone_iphone_rounded;
    } else {
      icon = Icons.devices_rounded;
    }

    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: UpdateScreen.cardColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: iconColor.withValues(alpha: 0.25),
            blurRadius: 24,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Center(
        child: Icon(icon, size: 50, color: iconColor),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════
// Widget: chip con el nombre del archivo a descargar
// ══════════════════════════════════════════════════════

class _FileNameChip extends StatelessWidget {
  const _FileNameChip({required this.fileName});

  final String fileName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.insert_drive_file_rounded,
              size: 14, color: Colors.white38),
          const SizedBox(width: 6),
          Text(
            fileName,
            style: GoogleFonts.manrope(
              fontSize: 12,
              color: Colors.white38,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════
// Widget: área inferior reactiva (progreso + botones)
// ══════════════════════════════════════════════════════

class _BottomActionArea extends StatelessWidget {
  const _BottomActionArea({required this.controller});

  final UpdateController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
      decoration: const BoxDecoration(
        color: UpdateScreen.backgroundColor,
        border: Border(
          top: BorderSide(color: Colors.white10, width: 0.5),
        ),
      ),
      child: Obx(() {
        final state = controller.downloadState.value;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Barra de progreso (solo durante descarga) ──────
            if (state == DownloadState.downloading) ...[
              _buildProgressBar(controller.downloadProgress.value),
              const SizedBox(height: 16),
            ],

            // ── Mensaje de error de descarga ───────────────────
            if (state == DownloadState.error) ...[
              _buildDownloadError(context, controller.downloadError.value),
              const SizedBox(height: 12),
            ],

            // ── Botón principal ────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 64,
              child: _buildMainButton(context, state),
            ),

            // ── Nota de plataforma (Linux / macOS / iOS) ───────
            if (GetPlatform.isLinux || GetPlatform.isMacOS || GetPlatform.isIOS)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  _platformNote,
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    color: Colors.white38,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        );
      }),
    );
  }

  // ── Barra de progreso ─────────────────────────────
  Widget _buildProgressBar(double progress) {
    final pct = (progress * 100).toStringAsFixed(0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Descargando...',
              style: GoogleFonts.manrope(
                fontSize: 13,
                color: Colors.white60,
              ),
            ),
            Text(
              '$pct%',
              style: GoogleFonts.manrope(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: UpdateScreen.accentColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: Colors.white12,
            valueColor: const AlwaysStoppedAnimation<Color>(
              UpdateScreen.accentColor,
            ),
          ),
        ),
      ],
    );
  }

  // ── Error de descarga ─────────────────────────────
  Widget _buildDownloadError(BuildContext context, String message) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: UpdateScreen.errorColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: UpdateScreen.errorColor.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded,
              color: UpdateScreen.errorColor, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: GoogleFonts.manrope(
                fontSize: 12,
                color: UpdateScreen.errorColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Botón principal ───────────────────────────────
  Widget _buildMainButton(BuildContext context, DownloadState state) {
    // Estado: descargando → botón deshabilitado con spinner
    if (state == DownloadState.downloading) {
      return ElevatedButton.icon(
        onPressed: null,
        icon: const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            color: Colors.black54,
            strokeWidth: 2,
          ),
        ),
        label: Text(
          'DESCARGANDO...',
          style: GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        style: _buttonStyle(UpdateScreen.accentColor.withValues(alpha: 0.5)),
      );
    }

    // Estado: listo para instalar (Android / Windows)
    if (state == DownloadState.done &&
        (GetPlatform.isAndroid || GetPlatform.isWindows)) {
      return ElevatedButton.icon(
        onPressed: controller.installUpdate,
        icon: const Icon(Icons.install_mobile_rounded, size: 24),
        label: Text(
          'INSTALAR AHORA',
          style: GoogleFonts.manrope(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        style: _buttonStyle(UpdateScreen.successColor),
      );
    }

    // Estado: instalando
    if (state == DownloadState.installing) {
      return ElevatedButton.icon(
        onPressed: null,
        icon: const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            color: Colors.black54,
            strokeWidth: 2,
          ),
        ),
        label: Text(
          'INSTALANDO...',
          style: GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        style: _buttonStyle(UpdateScreen.successColor.withValues(alpha: 0.6)),
      );
    }

    // Estado: error → reintentar
    if (state == DownloadState.error) {
      return ElevatedButton.icon(
        onPressed: controller.retryDownload,
        icon: const Icon(Icons.refresh_rounded, size: 24),
        label: Text(
          'REINTENTAR',
          style: GoogleFonts.manrope(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        style: _buttonStyle(UpdateScreen.errorColor),
      );
    }

    // Estado: idle → botón de acción según plataforma
    return ElevatedButton.icon(
      onPressed: controller.startUpdate,
      icon: Icon(_platformIcon, size: 24),
      label: Text(
        controller.platformActionLabel.toUpperCase(),
        style: GoogleFonts.manrope(
          fontSize: 18,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.2,
        ),
      ),
      style: _buttonStyle(UpdateScreen.accentColor),
    );
  }

  ButtonStyle _buttonStyle(Color color) {
    return ElevatedButton.styleFrom(
      backgroundColor: color,
      foregroundColor: Colors.black87,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
    );
  }

  IconData get _platformIcon {
    if (GetPlatform.isAndroid) return Icons.download_rounded;
    if (GetPlatform.isWindows) return Icons.download_rounded;
    if (GetPlatform.isLinux || GetPlatform.isMacOS)
      return Icons.open_in_browser_rounded;
    if (GetPlatform.isIOS) return Icons.info_outline_rounded;
    return Icons.download_rounded;
  }

  String get _platformNote {
    if (GetPlatform.isLinux) {
      return 'Se abrirá el navegador para descargar el archivo .tar.gz.\nExtrae y ejecuta el binario incluido.';
    }
    if (GetPlatform.isMacOS) {
      return 'Se abrirá el navegador para descargar el .zip.\nExtrae la app y arrástrala a Aplicaciones.\nEs posible que necesites aprobarla en Preferencias → Seguridad.';
    }
    if (GetPlatform.isIOS) {
      return 'Abre la guía para instalar con tu propio servidor de firmas.';
    }
    return '';
  }
}
