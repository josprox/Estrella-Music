import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../generated/l10n.dart';
import 'update_controller.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({super.key});

  static const Color accentColor = Color(0xFFFF719A);
  static const Color backgroundColor = Color(0xFF0F0F12);
  static const Color cardColor = Color(0xFF1A1A1E);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateController());
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Obx(() {
        if (controller.isLoading.isTrue) {
          return const Center(
              child: CircularProgressIndicator(color: accentColor));
        }

        if (controller.error.isNotEmpty) {
          return _buildErrorState(context, controller);
        }

        final data = controller.updateInfo.value;
        if (data == null) {
          return Center(
              child: Text(S.of(context).infoNotAvailable,
                  style: const TextStyle(color: Colors.white)));
        }

        return SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 60.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 1. Central Icon Container
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.3),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.smartphone,
                            size: 50,
                            color: accentColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // 2. App Title (from API)
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

                      // 3. Version Pill
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
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
                      const SizedBox(height: 48),

                      // 4. Markdown Content Card
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

              // 5. Bottom Action Area
              _buildBottomButton(context, data),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildBottomButton(BuildContext context, Map<String, dynamic> data) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
      color: backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 64,
            child: ElevatedButton.icon(
              onPressed: () async {
                String? url = data['Descarga'];
                if (url != null) {
                  if (GetPlatform.isWindows) {
                    url = url.replaceAll('app-release.apk', 'EstrellaMusicInstaller.exe');
                  }
                  final uri = Uri.parse(url);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  }
                }
              },
              icon: const Icon(Icons.download, size: 24),
              label: Text(
                S.of(context).updateApp.toUpperCase(),
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                foregroundColor: Colors.black87,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, UpdateController controller) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 60, color: Colors.redAccent),
          const SizedBox(height: 24),
          Text(S.of(context).loadInfoUpdate,
              style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 8),
          Text(
            controller.error.value,
            style: const TextStyle(fontSize: 12, color: Colors.white54),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: controller.fetchUpdateInfo,
            style: ElevatedButton.styleFrom(backgroundColor: accentColor),
            child: Text(S.of(context).retry,
                style: const TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
