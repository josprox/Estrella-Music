# Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-dontwarn com.google.android.play.core.**

# For Google Play Services
-keep class com.google.android.gms.** { *; }

# For SQLite / Drift / Sqlite3
-keep class org.sqlite.** { *; }

# For Hive
-keep class com.github.iziachen.hive.** { *; }

# For Media Kit / Just Audio / Audio Service
-keep class com.ryanheise.audioservice.** { *; }
-keep class com.ryanheise.just_audio.** { *; }
-keep class com.alexmerced.media_kit.** { *; }
-keep class com.video_player.** { *; }

# For workmanager
-keep class be.tarsos.dsp.** { *; }
-keep class com.transistorsoft.flutter.backgroundfetch.** { *; }

# For JNI / JNIGEN
-keep class com.sun.jna.** { *; }
-keep class * implements com.sun.jna.** { *; }

# General rules to prevent stripping of native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep the generated plugin registrant
-keep class io.flutter.plugins.GeneratedPluginRegistrant { *; }
