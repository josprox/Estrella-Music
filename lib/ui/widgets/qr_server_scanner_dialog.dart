import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrServerScannerDialog extends StatefulWidget {
  const QrServerScannerDialog({super.key});

  static Future<String?> scan(BuildContext context) async {
    return showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (_) => const QrServerScannerDialog(),
    );
  }

  @override
  State<QrServerScannerDialog> createState() => _QrServerScannerDialogState();
}

class _QrServerScannerDialogState extends State<QrServerScannerDialog> {
  late final MobileScannerController _controller;
  bool _hasDetected = false;
  bool _isTorchOn = false;

  @override
  void initState() {
    super.initState();
    _controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
      torchEnabled: false,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_hasDetected) return;
    for (final barcode in capture.barcodes) {
      final raw = barcode.rawValue?.trim();
      if (raw != null && raw.isNotEmpty) {
        final parsedUrl = _extractServerUrl(raw);
        if (parsedUrl != null) {
          _hasDetected = true;
          Get.back(result: parsedUrl);
          return;
        }
      }
    }
  }

  static String? _extractServerUrl(String raw) {
    try {
      if (raw.startsWith('{') && raw.endsWith('}')) {
        final decoded = jsonDecode(raw);
        if (decoded is Map) {
          final url = decoded['serverUrl'] ?? decoded['url'] ?? decoded['endpoint'];
          if (url != null && url.toString().trim().isNotEmpty) {
            return url.toString().trim();
          }
        }
      }
    } catch (_) {}

    if (raw.startsWith('estrellamusic://') ||
        raw.startsWith('estrella://') ||
        raw.startsWith('emusic://')) {
      try {
        final uri = Uri.parse(raw);
        final paramUrl = uri.queryParameters['url'] ??
            uri.queryParameters['serverUrl'] ??
            uri.queryParameters['endpoint'];
        if (paramUrl != null && paramUrl.trim().isNotEmpty) {
          return paramUrl.trim();
        }
      } catch (_) {}
    }

    if (raw.startsWith('http://') || raw.startsWith('https://')) {
      return raw;
    }

    return raw;
  }

  Future<void> _pasteFromClipboard() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final text = data?.text?.trim();
    if (text != null && text.isNotEmpty) {
      final extracted = _extractServerUrl(text);
      if (extracted != null && mounted) {
        Get.back(result: extracted);
      }
    } else {
      Get.snackbar('Portapapeles', 'No se encontró una URL en el portapapeles');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = GetPlatform.isAndroid || GetPlatform.isIOS;
    return Dialog(
      backgroundColor: const Color(0xFF0F1E28),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420, maxHeight: 580),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.qr_code_scanner_rounded,
                          color: Color(0xFFFF9F1C), size: 26),
                      SizedBox(width: 10),
                      Text(
                        'Escanear Servidor QR',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white70),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Apunta al código QR del servidor de streaming o receta externa para conectarte.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: isMobile
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            MobileScanner(
                              controller: _controller,
                              onDetect: _onDetect,
                              errorBuilder: (context, error) {
                                return Container(
                                  color: Colors.black45,
                                  padding: const EdgeInsets.all(16),
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.camera_alt_outlined,
                                            size: 40, color: Colors.white54),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Cámara no disponible: ${error.errorCode.name}',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            // Overlay visual guide
                            Container(
                              width: 220,
                              height: 220,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFFFF9F1C),
                                  width: 2.5,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            // Torch button
                            Positioned(
                              bottom: 12,
                              right: 12,
                              child: IconButton.filled(
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.black54,
                                ),
                                icon: Icon(
                                  _isTorchOn
                                      ? Icons.flash_on_rounded
                                      : Icons.flash_off_rounded,
                                  color: _isTorchOn
                                      ? const Color(0xFFFF9F1C)
                                      : Colors.white,
                                ),
                                onPressed: () async {
                                  await _controller.toggleTorch();
                                  setState(() => _isTorchOn = !_isTorchOn);
                                },
                              ),
                            ),
                          ],
                        )
                      : Container(
                          color: Colors.black38,
                          padding: const EdgeInsets.all(24),
                          child: const Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.qr_code_2_rounded,
                                    size: 64, color: Color(0xFFFF9F1C)),
                                SizedBox(height: 12),
                                Text(
                                  'Cámara no compatible en esta plataforma.\nPega la URL del servidor directamente.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: _pasteFromClipboard,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: const Icon(Icons.content_paste_rounded, size: 18),
                label: const Text('Pegar URL desde el portapapeles'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
