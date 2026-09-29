// ignore_for_file: invalid_use_of_internal_member

import 'dart:ffi' as ffi;
import 'package:estrella_music/native_bindings/andrid_utils.dart';
import 'package:jni/_internal.dart';
import 'package:jni/jni.dart';

final class _AndroidBindings {
  static final _getApplicationContextPtr = ProtectedJniExtensions.lookup<
      ffi.NativeFunction<JObjectPtr Function()>>('GetApplicationContext');
  static final _getApplicationContext =
      _getApplicationContextPtr.asFunction<JObjectPtr Function()>();

  static final _getCurrentActivityPtr = ProtectedJniExtensions.lookup<
      ffi.NativeFunction<JObjectPtr Function()>>('GetCurrentActivity');
  static final _getCurrentActivity =
      _getCurrentActivityPtr.asFunction<JObjectPtr Function()>();

  static JObject? get applicationContext {
    final ptr = _getApplicationContext();
    if (ptr == ffi.nullptr) return null;
    return JObject.fromReference(JGlobalReference(ptr));
  }

  static JObject? get currentActivity {
    final ptr = _getCurrentActivity();
    if (ptr == ffi.nullptr) return null;
    return JObject.fromReference(JGlobalReference(ptr));
  }
}

class EqualizerService {
  static bool openEqualizer(int sessionId) {
    final activity = _AndroidBindings.currentActivity;
    final context = _AndroidBindings.applicationContext;
    if (activity == null || context == null) return false;
    final success = Equalizer().openEqualizer(sessionId, context, activity);
    activity.release();
    context.release();
    return success;
  }

  static void initAudioEffect(int sessionId) {
    final context = _AndroidBindings.applicationContext;
    if (context == null) return;
    Equalizer().initAudioEffect(sessionId, context);
    context.release();
  }

  static void endAudioEffect(int sessionId) {
    final context = _AndroidBindings.applicationContext;
    if (context == null) return;
    Equalizer().endAudioEffect(sessionId, context);
    context.release();
  }
}
