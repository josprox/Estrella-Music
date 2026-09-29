// Manual clean bindings for com.josprox.emusic.Equalizer and SDKInt for jni 1.0+
// ignore_for_file: camel_case_types

import 'dart:core' as core$_;
import 'package:jni/_internal.dart' as jni$_;
import 'package:jni/jni.dart' as jni$_;

/// from: `com.josprox.emusic.Equalizer`
class Equalizer extends jni$_.JObject {
  Equalizer.fromReference(
    jni$_.JReference reference,
  ) : super.fromReference(reference);

  static final _class =
      jni$_.JClass.forName(r'com/josprox/emusic/Equalizer');

  static final _id_new$ = _class.constructorId(
    r'()V',
  );

  static final _new$ = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_NewObject')
      .asFunction<
          jni$_.JniResult Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public void <init>()`
  factory Equalizer() {
    final classRef = _class.reference;
    return Equalizer.fromReference(
        _new$(classRef.pointer, _id_new$.pointer)
            .reference);
  }

  static final _id_openEqualizer = _class.instanceMethodId(
    r'openEqualizer',
    r'(ILandroid/content/Context;Landroid/app/Activity;)Z',
  );

  static final _openEqualizer = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                  jni$_.Pointer<jni$_.Void>,
                  jni$_.JMethodIDPtr,
                  jni$_.VarArgs<
                      (
                        jni$_.Int32,
                        jni$_.Pointer<jni$_.Void>,
                        jni$_.Pointer<jni$_.Void>
                      )>)>>('globalEnv_CallBooleanMethod')
      .asFunction<
          jni$_.JniResult Function(
              jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr,
              core$_.int,
              jni$_.Pointer<jni$_.Void>,
              jni$_.Pointer<jni$_.Void>)>();

  /// from: `public final boolean openEqualizer(int i, android.content.Context context, android.app.Activity activity)`
  core$_.bool openEqualizer(
    core$_.int i,
    jni$_.JObject context,
    jni$_.JObject activity,
  ) {
    final _$context = context.reference;
    final _$activity = activity.reference;
    return _openEqualizer(
            reference.pointer,
            _id_openEqualizer.pointer,
            i,
            _$context.pointer,
            _$activity.pointer)
        .boolean;
  }

  static final _id_initAudioEffect = _class.instanceMethodId(
    r'initAudioEffect',
    r'(ILandroid/content/Context;)V',
  );

  static final _initAudioEffect = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JThrowablePtr Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_
                          .VarArgs<(jni$_.Int32, jni$_.Pointer<jni$_.Void>)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, core$_.int, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public final void initAudioEffect(int i, android.content.Context context)`
  void initAudioEffect(
    core$_.int i,
    jni$_.JObject context,
  ) {
    final _$context = context.reference;
    _initAudioEffect(reference.pointer,
            _id_initAudioEffect.pointer, i, _$context.pointer)
        .check();
  }

  static final _id_endAudioEffect = _class.instanceMethodId(
    r'endAudioEffect',
    r'(ILandroid/content/Context;)V',
  );

  static final _endAudioEffect = jni$_.ProtectedJniExtensions.lookup<
              jni$_.NativeFunction<
                  jni$_.JThrowablePtr Function(
                      jni$_.Pointer<jni$_.Void>,
                      jni$_.JMethodIDPtr,
                      jni$_
                          .VarArgs<(jni$_.Int32, jni$_.Pointer<jni$_.Void>)>)>>(
          'globalEnv_CallVoidMethod')
      .asFunction<
          jni$_.JThrowablePtr Function(jni$_.Pointer<jni$_.Void>,
              jni$_.JMethodIDPtr, core$_.int, jni$_.Pointer<jni$_.Void>)>();

  /// from: `public final void endAudioEffect(int i, android.content.Context context)`
  void endAudioEffect(
    core$_.int i,
    jni$_.JObject context,
  ) {
    final _$context = context.reference;
    _endAudioEffect(reference.pointer, _id_endAudioEffect.pointer,
            i, _$context.pointer)
        .check();
  }
}

/// from: `com.josprox.emusic.SDKInt$Companion`
class SDKInt$Companion extends jni$_.JObject {
  SDKInt$Companion.fromReference(
    jni$_.JReference reference,
  ) : super.fromReference(reference);

  static final _class =
      jni$_.JClass.forName(r'com/josprox/emusic/SDKInt$Companion');

  static final _id_getSDKInt = _class.instanceMethodId(
    r'getSDKInt',
    r'()I',
  );

  static final _getSDKInt = jni$_.ProtectedJniExtensions.lookup<
          jni$_.NativeFunction<
              jni$_.JniResult Function(
                jni$_.Pointer<jni$_.Void>,
                jni$_.JMethodIDPtr,
              )>>('globalEnv_CallIntMethod')
      .asFunction<
          jni$_.JniResult Function(
            jni$_.Pointer<jni$_.Void>,
            jni$_.JMethodIDPtr,
          )>();

  /// from: `public final int getSDKInt()`
  core$_.int getSDKInt() {
    return _getSDKInt(reference.pointer, _id_getSDKInt.pointer)
        .integer;
  }
}

final class $SDKInt$Companion$Type extends jni$_.JType<SDKInt$Companion> {
  const $SDKInt$Companion$Type();

  @core$_.override
  core$_.String get signature => r'Lcom/josprox/emusic/SDKInt$Companion;';
}

/// from: `com.josprox.emusic.SDKInt`
class SDKInt extends jni$_.JObject {
  SDKInt.fromReference(
    jni$_.JReference reference,
  ) : super.fromReference(reference);

  static final _class =
      jni$_.JClass.forName(r'com/josprox/emusic/SDKInt');

  static final _id_Companion = _class.staticFieldId(
    r'Companion',
    r'Lcom/josprox/emusic/SDKInt$Companion;',
  );

  /// from: `static public final com.josprox.emusic.SDKInt$Companion Companion`
  static SDKInt$Companion get Companion =>
      _id_Companion.get(_class, const $SDKInt$Companion$Type());
}
