import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:estrella_music/services/storage/sqlite_store.dart';
import 'package:estrella_music/services/sync/sync_service.dart';
import 'package:estrella_music/music_provider/music_provider_manager.dart';
import 'package:estrella_music/profiles/profile_manager.dart';
import 'package:estrella_music/ui/home.dart';
import 'package:estrella_music/ui/profiles/profile_switcher.dart';
import 'package:estrella_music/ui/widgets/qr_server_scanner_dialog.dart';
import 'widgets/animated_auth_background.dart';

class WelcomeProfileSetupScreen extends StatefulWidget {
  const WelcomeProfileSetupScreen({super.key});

  @override
  State<WelcomeProfileSetupScreen> createState() =>
      _WelcomeProfileSetupScreenState();
}

class _WelcomeProfileSetupScreenState extends State<WelcomeProfileSetupScreen> {
  late String _selectedProvider;
  String? _customFolder;
  bool _isSettingUp = false;

  final TextEditingController _nameController =
      TextEditingController(text: 'Música Local');
  final TextEditingController _serverUrlController = TextEditingController();

  MusicProviderManager get _providerManager => Get.find<MusicProviderManager>();

  bool _isLocal(String providerId) =>
      _providerManager.registrationFor(providerId)?.trust ==
      ProviderTrust.local;

  @override
  void initState() {
    super.initState();
    _selectedProvider = _providerManager.localProviderId;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _serverUrlController.dispose();
    super.dispose();
  }

  String _setupStepMessage = 'Estamos preparando tu experiencia...';

  Future<void> _completeSetup() async {
    setState(() {
      _isSettingUp = true;
      _setupStepMessage = 'Estamos preparando tu experiencia...';
    });
    final profileManager = Get.find<ProfileManager>();

    try {
      final name = _nameController.text.trim().isEmpty
          ? (_isLocal(_selectedProvider)
              ? 'Música Local'
              : _providerManager
                      .registrationFor(_selectedProvider)
                      ?.displayName ??
                  'Streaming Externo')
          : _nameController.text.trim();

      final existing = profileManager.profiles.firstWhereOrNull(
        (p) => p.providerId == _selectedProvider,
      );

      if (mounted) {
        setState(() => _setupStepMessage = 'Configurando perfil musical...');
      }
      await Future.delayed(const Duration(milliseconds: 350));

      final serverUrl = _serverUrlController.text.trim();

      if (existing != null) {
        final updated = existing.copyWith(
          name: name,
          settings: {
            ...existing.settings,
            if (_customFolder != null && _isLocal(_selectedProvider))
              'libraryRoots': [_customFolder],
            if (!_isLocal(_selectedProvider) && serverUrl.isNotEmpty)
              'serverUrl': serverUrl,
          },
        );
        await profileManager.saveProfile(updated);
        await profileManager.switchProfile(existing.id);
      } else {
        final created = await profileManager.createProfile(
          name: name,
          providerId: _selectedProvider,
          settings: {
            if (_customFolder != null && _isLocal(_selectedProvider))
              'libraryRoots': [_customFolder],
            if (!_isLocal(_selectedProvider) && serverUrl.isNotEmpty)
              'serverUrl': serverUrl,
          },
        );
        await profileManager.switchProfile(created.id);
      }

      final box = await SqliteStore.openBox('AppPrefs');
      await box.put('welcomeProfileOnboardingCompleted', true);
      await box.close();

      if (profileManager.activeProfileMaySync &&
          Get.isRegistered<SyncService>()) {
        if (mounted) {
          setState(
              () => _setupStepMessage = 'Sincronizando con tu nube eMusic...');
        }
        try {
          await Get.find<SyncService>()
              .pull()
              .timeout(const Duration(seconds: 15));
        } catch (_) {}
      } else {
        if (mounted) {
          setState(() => _setupStepMessage = 'Cargando biblioteca local...');
        }
      }

      if (mounted) {
        setState(() => _setupStepMessage = 'Casi listo...');
      }
      await ProfileSwitcher.refreshActiveContext();
      await Future.delayed(const Duration(milliseconds: 500));

      Get.offAll(() => const Home());
    } catch (e) {
      if (mounted) {
        Get.snackbar('Configuración', 'Error al preparar perfil: $e');
        setState(() => _isSettingUp = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isSettingUp) {
      return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            const AnimatedAuthBackground(),
            Container(color: Colors.black.withValues(alpha: 0.5)),
            SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              const Color(0xFFFF9F1C).withValues(alpha: 0.15),
                        ),
                        child: const Center(
                          child: SizedBox(
                            width: 38,
                            height: 38,
                            child: CircularProgressIndicator(
                              strokeWidth: 3.5,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xFFFF9F1C)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Estamos preparando tu experiencia',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          _setupStepMessage,
                          key: ValueKey(_setupStepMessage),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 14.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Esto puede tardar unos segundos. Por favor, espera.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.4),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const AnimatedAuthBackground(),
          Container(color: Colors.black.withValues(alpha: 0.3)),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 580),
                  child: Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F1E28).withValues(alpha: 0.92),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.12),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.35),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF9F1C)
                                    .withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                Icons.queue_music_rounded,
                                color: Color(0xFFFF9F1C),
                                size: 30,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Bienvenido a Estrella Music',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Configura tu experiencia musical inicial',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Selecciona cómo quieres escuchar hoy:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 14),
                        for (final providerId
                            in _providerManager.availableProviderIds) ...[
                          _buildOptionCard(
                            providerId: providerId,
                            title: _isLocal(providerId)
                                ? 'Modo local (Por defecto offline)'
                                : 'Reproducción de streaming externo',
                            subtitle: _isLocal(providerId)
                                ? 'Reproductor local de tu dispositivo. No requiere internet ni servidores externos.'
                                : 'Conecta un servidor de recetas o streaming externo (estilo Stremio).',
                            icon: _isLocal(providerId)
                                ? Icons.phone_android_rounded
                                : Icons.cloud_done_rounded,
                            accentColor: _isLocal(providerId)
                                ? const Color(0xFF2EC4B6)
                                : const Color(0xFFFF9F1C),
                          ),
                          const SizedBox(height: 12),
                        ],
                        const SizedBox(height: 12),
                        // Disclaimer banner for liability
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF9F1C).withValues(alpha: 0.10),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFFFF9F1C).withValues(alpha: 0.28),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.verified_user_outlined,
                                color: Color(0xFFFF9F1C),
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Aviso: Las reproducciones externas no nos hacemos responsables de cómo se usen. Estrella Music funciona por defecto como reproductor local offline.',
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.85),
                                    fontSize: 12,
                                    height: 1.35,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _nameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Nombre de tu perfil',
                            labelStyle: const TextStyle(color: Colors.white70),
                            prefixIcon: const Icon(Icons.badge_outlined,
                                color: Colors.white70),
                            filled: true,
                            fillColor: Colors.white.withValues(alpha: 0.06),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: Colors.white.withValues(alpha: 0.15)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: Colors.white.withValues(alpha: 0.15)),
                            ),
                          ),
                        ),
                        if (_isLocal(_selectedProvider)) ...[
                          const SizedBox(height: 14),
                          OutlinedButton.icon(
                            onPressed: () async {
                              final folder =
                                  await FilePicker.platform.getDirectoryPath();
                              if (folder != null) {
                                setState(() => _customFolder = folder);
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: BorderSide(
                                  color: Colors.white.withValues(alpha: 0.2)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                            ),
                            icon: const Icon(Icons.folder_open_rounded),
                            label: Text(
                              _customFolder != null
                                  ? 'Carpeta: $_customFolder'
                                  : 'Carpeta personalizada (opcional)',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ] else ...[
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _serverUrlController,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText:
                                        'URL del servidor (opcional / personalizado)',
                                    hintText: 'https://tu-servidor-o-receta.com',
                                    hintStyle: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.3),
                                    ),
                                    labelStyle:
                                        const TextStyle(color: Colors.white70),
                                    prefixIcon: const Icon(Icons.link_rounded,
                                        color: Colors.white70),
                                    filled: true,
                                    fillColor:
                                        Colors.white.withValues(alpha: 0.06),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                          color: Colors.white
                                              .withValues(alpha: 0.15)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(
                                          color: Colors.white
                                              .withValues(alpha: 0.15)),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              IconButton.filled(
                                style: IconButton.styleFrom(
                                  backgroundColor: const Color(0xFFFF9F1C)
                                      .withValues(alpha: 0.2),
                                  padding: const EdgeInsets.all(14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                tooltip: 'Escanear QR de servidor',
                                icon: const Icon(Icons.qr_code_scanner_rounded,
                                    color: Color(0xFFFF9F1C)),
                                onPressed: () async {
                                  final scanned =
                                      await QrServerScannerDialog.scan(context);
                                  if (scanned != null && scanned.isNotEmpty) {
                                    setState(
                                        () => _serverUrlController.text = scanned);
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                        const SizedBox(height: 26),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _isSettingUp ? null : _completeSetup,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF9F1C),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                            ),
                            child: _isSettingUp
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'Comenzar a escuchar',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ],
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

  Widget _buildOptionCard({
    required String providerId,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color accentColor,
  }) {
    final isSelected = _selectedProvider == providerId;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedProvider = providerId;
          if (_nameController.text == 'Mi Música' ||
              _nameController.text == 'Música Local' ||
              _nameController.text == 'eMusic Cloud' ||
              _nameController.text == 'Streaming Externo') {
            _nameController.text = _isLocal(providerId)
                ? 'Música Local'
                : 'Streaming Externo';
          }
        });
      },
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? accentColor.withValues(alpha: 0.15)
              : Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color:
                isSelected ? accentColor : Colors.white.withValues(alpha: 0.12),
            width: isSelected ? 1.8 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected
                    ? accentColor.withValues(alpha: 0.25)
                    : Colors.white.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(icon,
                  color: isSelected ? accentColor : Colors.white70, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 12.5,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              isSelected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_off_rounded,
              color: isSelected ? accentColor : Colors.white38,
            ),
          ],
        ),
      ),
    );
  }
}
