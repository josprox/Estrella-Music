import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Constantes de AudioEffect del SDK de Android.
/// Los valores son estables y no cambian entre versiones.
const _actionDisplayAudioEffectControlPanel =
    'android.media.action.DISPLAY_AUDIO_EFFECT_CONTROL_PANEL';
const _extraAudioSession = 'android.media.extra.AUDIO_SESSION';
const _extraPackageName = 'android.media.extra.PACKAGE_NAME';
const _extraContentType = 'android.media.extra.CONTENT_TYPE';
const _contentTypeMusic = 2; // AudioEffect.CONTENT_TYPE_MUSIC

/// Servicio para abrir el ecualizador del sistema Android.
/// Usa [android_intent_plus] — sin JNI, sin Kotlin personalizado.
class EqualizerService {
  /// Abre el ecualizador del sistema para el [sessionId] dado.
  /// Devuelve true si se encontró y lanzó algún ecualizador.
  static Future<bool> openEqualizer(int sessionId) async {
    if (!GetPlatform.isAndroid) return false;

    final info = await PackageInfo.fromPlatform();
    final appPackage = info.packageName;

    // Intento principal: ecualizador estándar de Android
    try {
      final intent = AndroidIntent(
        action: _actionDisplayAudioEffectControlPanel,
        arguments: {
          _extraPackageName: appPackage,
          _extraAudioSession: sessionId,
          _extraContentType: _contentTypeMusic,
        },
        flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
      );
      await intent.launch();
      return true;
    } catch (_) {
      // No hay ecualizador estándar; intentamos fabricantes
    }

    // Fallback: actividades y ecualizadores de fabricantes conocidos
    final fallbackIntents = [
      // Xiaomi / MIUI / HyperOS Audio Effects
      const AndroidIntent(
        action: 'android.intent.action.MAIN',
        package: 'com.miui.audioeffect',
        componentName: 'com.miui.audioeffect.AudioEffectActivity',
        flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
      ),
      const AndroidIntent(
        action: 'android.intent.action.MAIN',
        package: 'com.miui.audioeffect',
        flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
      ),
      // Samsung SoundAlive
      const AndroidIntent(
        action: 'android.intent.action.MAIN',
        package: 'com.samsung.android.soundalive',
        flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
      ),
      // OnePlus Audio Tuner
      const AndroidIntent(
        action: 'android.intent.action.MAIN',
        package: 'com.oneplus.sound.tuner',
        flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
      ),
      // Android Settings -> Sound Settings Activity
      const AndroidIntent(
        action: 'android.intent.action.MAIN',
        package: 'com.android.settings',
        componentName: 'com.android.settings.Settings\$SoundSettingsActivity',
        flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
      ),
    ];

    for (final intent in fallbackIntents) {
      try {
        await intent.launch();
        return true;
      } catch (_) {
        continue;
      }
    }

    // Último recurso: ajustes de sonido del sistema
    try {
      await AndroidIntent(
        action: 'android.settings.SOUND_SETTINGS',
        flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
      ).launch();
      return true;
    } catch (_) {
      return false;
    }
  }
}
