import 'dart:ui';
import 'package:flutter/material.dart';
import 'widgets/animated_auth_background.dart';

class CloudModeChoiceScreen extends StatefulWidget {
  const CloudModeChoiceScreen({
    super.key,
    required this.onKeepLocal,
    required this.onChooseCloud,
  });

  final VoidCallback onKeepLocal;
  final VoidCallback onChooseCloud;

  @override
  State<CloudModeChoiceScreen> createState() => _CloudModeChoiceScreenState();
}

class _CloudModeChoiceScreenState extends State<CloudModeChoiceScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const Map<String, Map<String, String>> _translations = {
    'es': {
      'welcome_title': 'Tu música, a tu manera',
      'welcome_subtitle': 'Elige cómo quieres experimentar Estrella Music de ahora en adelante.',
      'welcome_intro': 'Hemos modernizado nuestra plataforma. El antiguo sistema de subir respaldos manuales ha sido desactivado. Ahora cuentas con dos modos claros para gestionar tu biblioteca musical.',
      'recommend_cloud': 'Te recomendamos activar el Modo Cloud para una experiencia Spotify-like: sincronización en tiempo real entre todos tus dispositivos y respaldo automático sin que tengas que hacer nada.',
      'swipe_prompt': 'Desliza para explorar las opciones',
      
      'local_title': 'Modo Local',
      'local_subtitle': 'Privacidad absoluta en tu dispositivo',
      'local_b1': 'Funciona sin necesidad de iniciar sesión.',
      'local_b2': 'Toda tu biblioteca se queda estrictamente en este equipo.',
      'local_b3': 'Nota: Sin respaldos manuales en la nube. Si pierdes tu dispositivo o desinstalas la app, tus datos no se podrán recuperar.',
      'local_btn': 'Usar solo en este dispositivo',
      
      'cloud_title': 'Modo Cloud (Recomendado)',
      'cloud_subtitle': 'Sincronización en tiempo real con Joss Red',
      'cloud_b1': 'Inicia sesión de forma segura usando tu cuenta de Joss Red.',
      'cloud_b2': 'Accede a tus playlists, favoritos e historial desde cualquier dispositivo (Windows, Android, etc.) al instante.',
      'cloud_b3': 'Sincronización inteligente: trabaja sin conexión y sube los cambios automáticamente al recuperar internet.',
      'cloud_btn': 'Activar sincronización Cloud',
      
      'slide_indicator': 'Paso {current} de 3'
    },
    'en': {
      'welcome_title': 'Your music, your way',
      'welcome_subtitle': 'Choose how you want to experience Estrella Music from now on.',
      'welcome_intro': 'We have modernized our platform. The old manual backup upload system has been disabled. Now you have two clear ways to manage your music library.',
      'recommend_cloud': 'We highly recommend activating Cloud Mode for a seamless Spotify-like experience: real-time synchronization across all your devices and automatic backups without any manual action.',
      'swipe_prompt': 'Swipe to explore options',
      
      'local_title': 'Local Mode',
      'local_subtitle': 'Absolute privacy on your device',
      'local_b1': 'Works without needing to log in.',
      'local_b2': 'Your entire library stays strictly on this device.',
      'local_b3': 'Note: No manual cloud backups. If you lose your device or uninstall the app, your data cannot be recovered.',
      'local_btn': 'Use only on this device',
      
      'cloud_title': 'Cloud Mode (Recommended)',
      'cloud_subtitle': 'Real-time sync with Joss Red',
      'cloud_b1': 'Log in securely using your Joss Red account.',
      'cloud_b2': 'Access your playlists, favorites, and history on any device (Windows, Android, etc.) instantly.',
      'cloud_b3': 'Smart synchronization: works offline and uploads changes automatically when reconnected.',
      'cloud_btn': 'Activate Cloud Sync',
      
      'slide_indicator': 'Step {current} of 3'
    }
  };

  String _getTxt(BuildContext context, String key) {
    final locale = Localizations.localeOf(context).languageCode;
    final langMap = _translations[locale] ?? _translations['es']!;
    return langMap[key] ?? '';
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const AnimatedAuthBackground(),
          Container(color: Colors.black.withValues(alpha: 0.45)),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.graphic_eq_rounded,
                        color: Colors.white,
                        size: 38,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Estrella Music',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: const ScrollBehavior().copyWith(
                      dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                        PointerDeviceKind.trackpad,
                      },
                    ),
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      children: [
                        _buildWelcomeSlide(theme),
                        _buildCloudSlide(theme),
                        _buildLocalSlide(theme),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _getTxt(context, 'slide_indicator').replaceFirst('{current}', '${_currentPage + 1}'),
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (index) => _buildDot(index)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    final isActive = _currentPage == index;
    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: isActive ? 24 : 8,
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.white30,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildCardContainer({required List<Widget> children, Color borderColor = Colors.white12}) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          padding: const EdgeInsets.all(28),
          constraints: const BoxConstraints(maxWidth: 540),
          decoration: BoxDecoration(
            color: const Color(0xFF0C1721).withValues(alpha: 0.88),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 32,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSlide(ThemeData theme) {
    return _buildCardContainer(
      borderColor: Colors.white.withValues(alpha: 0.15),
      children: [
        const Center(
          child: Icon(
            Icons.headphones_rounded,
            color: Color(0xFF2EC4B6),
            size: 64,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          _getTxt(context, 'welcome_title'),
          style: theme.textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          _getTxt(context, 'welcome_subtitle'),
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 14,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          _getTxt(context, 'welcome_intro'),
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 14,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFF9F1C).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFFF9F1C).withValues(alpha: 0.25)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.star_rounded, color: Color(0xFFFF9F1C), size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _getTxt(context, 'recommend_cloud'),
                  style: const TextStyle(
                    color: Color(0xFFFFD199),
                    fontSize: 12.5,
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Center(
          child: TextButton.icon(
            onPressed: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            icon: const Icon(Icons.arrow_forward_rounded, color: Colors.white70),
            label: Text(
              _getTxt(context, 'swipe_prompt'),
              style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocalSlide(ThemeData theme) {
    const accent = Color(0xFF2EC4B6);
    return _buildCardContainer(
      borderColor: accent.withValues(alpha: 0.25),
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.phone_android_rounded, color: accent, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getTxt(context, 'local_title'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    _getTxt(context, 'local_subtitle'),
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 12.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildBulletPoint(accent, _getTxt(context, 'local_b1')),
        _buildBulletPoint(accent, _getTxt(context, 'local_b2')),
        _buildBulletPoint(accent, _getTxt(context, 'local_b3')),
        const SizedBox(height: 28),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: OutlinedButton.icon(
            onPressed: widget.onKeepLocal,
            icon: const Icon(Icons.cloud_off_rounded),
            label: Text(
              _getTxt(context, 'local_btn'),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white70,
              side: const BorderSide(color: Colors.white24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCloudSlide(ThemeData theme) {
    const accent = Color(0xFFFF9F1C);
    return _buildCardContainer(
      borderColor: accent.withValues(alpha: 0.45),
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.cloud_sync_rounded, color: accent, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getTxt(context, 'cloud_title'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    _getTxt(context, 'cloud_subtitle'),
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 12.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildBulletPoint(accent, _getTxt(context, 'cloud_b1')),
        _buildBulletPoint(accent, _getTxt(context, 'cloud_b2')),
        _buildBulletPoint(accent, _getTxt(context, 'cloud_b3')),
        const SizedBox(height: 28),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton.icon(
            onPressed: widget.onChooseCloud,
            icon: const Icon(Icons.cloud_done_rounded),
            label: Text(
              _getTxt(context, 'cloud_btn'),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: accent,
              foregroundColor: const Color(0xFF0C1721),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBulletPoint(Color color, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle_rounded, color: color, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 13.5,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
