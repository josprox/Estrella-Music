import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:palette_generator/palette_generator.dart';
import '/utils/helper.dart';

class ThemeController extends GetxController {
  final primaryColor = const Color(0xFF6C63FF).obs;
  final textColor = Colors.white.obs;
  final themedata = Rxn<ThemeData>();

  final platform = const MethodChannel('win_titlebar_color');
  String? currentSongId;
  late Brightness systemBrightness;
  ThemeType? _lastThemeType;
  Brightness? _lastBrightness;
  Color? _lastPrimaryColor;
  ColorScheme? _lastDynamicColors;

  ThemeController() {
    systemBrightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;

    // Read stored seed color (falls back to violet)
    final storedColor = Hive.box('AppPrefs').get("themePrimaryColor");
    if (storedColor != null) {
      primaryColor.value = Color(storedColor as int);
    }

    changeThemeModeType(
        ThemeType.values[Hive.box('AppPrefs').get("themeModeType") ?? 0]);

    _listenSystemBrightness();
    super.onInit();
  }

  void _listenSystemBrightness() {
    final dispatcher = WidgetsBinding.instance.platformDispatcher;
    dispatcher.onPlatformBrightnessChanged = () {
      systemBrightness = dispatcher.platformBrightness;
      changeThemeModeType(
          ThemeType.values[Hive.box('AppPrefs').get("themeModeType")],
          sysCall: true);
    };
  }

  void changeThemeModeType(dynamic value, {bool sysCall = false, ColorScheme? dynamicColors}) {
    final themeType = value is ThemeType ? value : ThemeType.values[value ?? 0];
    
    // Determine brightness
    Brightness brightness;
    if (themeType == ThemeType.system || themeType == ThemeType.dynamic) {
      brightness = systemBrightness;
    } else {
      brightness = themeType == ThemeType.light ? Brightness.light : Brightness.dark;
    }

    // Prioritize song's dominant color palette (primaryColor) over system dynamic colors when a song is active
    final finalDynamicColors = (currentSongId != null) ? null : dynamicColors;

    // Check if parameters changed to avoid infinite post-frame rebuild loops
    if (_lastThemeType == themeType &&
        _lastBrightness == brightness &&
        _lastPrimaryColor == primaryColor.value &&
        _lastDynamicColors == finalDynamicColors &&
        themedata.value != null) {
      return;
    }

    _lastThemeType = themeType;
    _lastBrightness = brightness;
    _lastPrimaryColor = primaryColor.value;
    _lastDynamicColors = finalDynamicColors;

    themedata.value = _buildThemeData(
      primaryColor.value, 
      brightness, 
      dynamicColors: finalDynamicColors
    );
    setWindowsTitleBarColor(themedata.value!.scaffoldBackgroundColor);
  }

  /// Called from player when a new song starts — extracts dominant color
  /// and rebuilds the dynamic theme.
  void setTheme(ImageProvider imageProvider, String songId) async {
    if (songId == currentSongId) return;
    PaletteGenerator generator = await PaletteGenerator.fromImageProvider(
        ResizeImage(imageProvider, height: 200, width: 200));

    final paletteColor = generator.dominantColor ??
        generator.darkMutedColor ??
        generator.darkVibrantColor ??
        generator.lightMutedColor ??
        generator.lightVibrantColor;

    if (paletteColor == null) return;

    Color seed = paletteColor.color;
    textColor.value = paletteColor.bodyTextColor;

    // Adjust seed for visibility if necessary, but keep it mostly true to the art
    primaryColor.value = seed;
    
    final type = ThemeType.values[Hive.box('AppPrefs').get("themeModeType") ?? 0];
    Brightness brightness;
    if (type == ThemeType.light) {
      brightness = Brightness.light;
    } else if (type == ThemeType.dark) {
      brightness = Brightness.dark;
    } else {
      // dynamic or system â†’ follow the actual system brightness
      brightness = systemBrightness;
    }

    themedata.value = _buildThemeData(seed, brightness);
    currentSongId = songId;

    Hive.box('AppPrefs').put("themePrimaryColor", primaryColor.value.toARGB32());
    setWindowsTitleBarColor(themedata.value!.scaffoldBackgroundColor);
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Theme builder — Material 3 enabled for all modes
  // ─────────────────────────────────────────────────────────────────────────

  ThemeData _buildThemeData(Color seedColor, Brightness brightness, {ColorScheme? dynamicColors}) {
    final isDark = brightness == Brightness.dark;
    _applySystemUiOverlay(isDark);

    ColorScheme colorScheme;
    if (dynamicColors != null) {
      colorScheme = dynamicColors;
    } else {
      colorScheme = ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: brightness,
        dynamicSchemeVariant: DynamicSchemeVariant.expressive,
      );
    }

    // Material 3 typography (2021 spec)
    final textTheme = Typography.material2021(platform: defaultTargetPlatform)
        .black
        .apply(displayColor: colorScheme.onSurface, bodyColor: colorScheme.onSurface);

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: colorScheme.surface,
      canvasColor: colorScheme.surface,
      cardColor: colorScheme.surfaceContainerLow,

      // ── AppBar ────────────────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: colorScheme.surfaceTint,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 3,
        shadowColor: colorScheme.shadow.withValues(alpha: 0.15),
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
        iconTheme: IconThemeData(color: colorScheme.onSurfaceVariant, size: 24),
        actionsIconTheme: IconThemeData(color: colorScheme.onSurfaceVariant, size: 24),
      ),

      // ── Bottom Sheet ──────────────────────────────────────────────────────
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surfaceContainerLow,
        surfaceTintColor: colorScheme.surfaceTint,
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        modalBarrierColor: Colors.black.withValues(alpha: 0.45),
      ),

      // ── Navigation Bar (M3 — used as reference for GNav styling) ─────────
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: colorScheme.surfaceTint,
        elevation: 0,
        height: 72,
        indicatorColor: colorScheme.secondaryContainer,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w700,
              fontSize: 11,
              letterSpacing: 0.3,
            );
          }
          return TextStyle(
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
            fontSize: 11,
            letterSpacing: 0.3,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(
              color: colorScheme.onSecondaryContainer,
              size: 24,
            );
          }
          return IconThemeData(
            color: colorScheme.onSurfaceVariant,
            size: 24,
          );
        }),
      ),

      // ── Navigation Rail ───────────────────────────────────────────────────
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        indicatorColor: colorScheme.secondaryContainer,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        selectedIconTheme: IconThemeData(color: colorScheme.onSecondaryContainer, size: 24),
        unselectedIconTheme: IconThemeData(color: colorScheme.onSurfaceVariant, size: 22),
        selectedLabelTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
        unselectedLabelTextStyle: TextStyle(
          color: colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
      ),

      // ── Card ──────────────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainerLow,
        shadowColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
      ),

      // ── Chip ──────────────────────────────────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainerHighest,
        selectedColor: colorScheme.secondaryContainer,
        labelStyle: TextStyle(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
        side: BorderSide(color: colorScheme.outlineVariant, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        checkmarkColor: colorScheme.onSecondaryContainer,
        elevation: 0,
        pressElevation: 0,
      ),

      // ── List Tile ─────────────────────────────────────────────────────────
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
        subtitleTextStyle: TextStyle(
          color: colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w400,
          fontSize: 13,
        ),
        leadingAndTrailingTextStyle: TextStyle(
          color: colorScheme.onSurfaceVariant,
          fontSize: 12,
        ),
        iconColor: colorScheme.onSurfaceVariant,
        tileColor: Colors.transparent,
        selectedTileColor: colorScheme.secondaryContainer.withValues(alpha: 0.5),
        selectedColor: colorScheme.onSecondaryContainer,
      ),

      // ── Elevated Button ───────────────────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primaryContainer,
          foregroundColor: colorScheme.onPrimaryContainer,
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            letterSpacing: 0.1,
          ),
        ),
      ),

      // ── Filled Button ─────────────────────────────────────────────────────
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            letterSpacing: 0.1,
          ),
        ),
      ),

      // ── Outlined Button ───────────────────────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.outline, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            letterSpacing: 0.1,
          ),
        ),
      ),

      // ── Text Button ───────────────────────────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            letterSpacing: 0.1,
          ),
        ),
      ),

      // ── Icon Button ───────────────────────────────────────────────────────
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: colorScheme.onSurfaceVariant,
          highlightColor: colorScheme.primary.withValues(alpha: 0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // ── Slider ────────────────────────────────────────────────────────────
      sliderTheme: SliderThemeData(
        inactiveTrackColor: colorScheme.onSurface.withValues(alpha: 0.15),
        activeTrackColor: colorScheme.primary,
        secondaryActiveTrackColor: colorScheme.primary.withValues(alpha: 0.3),
        thumbColor: colorScheme.primary,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 18),
        valueIndicatorColor: colorScheme.primary,
        valueIndicatorTextStyle: TextStyle(color: colorScheme.onPrimary),
        trackHeight: 4,
        trackShape: const RoundedRectSliderTrackShape(),
      ),

      // ── Progress Indicator ────────────────────────────────────────────────
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
        linearTrackColor: colorScheme.onSurface.withValues(alpha: 0.12),
        circularTrackColor: colorScheme.onSurface.withValues(alpha: 0.08),
        linearMinHeight: 4,
      ),

      // ── Input / Text Field ────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorScheme.error, width: 1.5),
        ),
        hintStyle: TextStyle(color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6)),
        labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
        prefixIconColor: colorScheme.onSurfaceVariant,
        suffixIconColor: colorScheme.onSurfaceVariant,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),

      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colorScheme.primary,
        selectionColor: colorScheme.primary.withValues(alpha: 0.3),
        selectionHandleColor: colorScheme.primary,
      ),

      // ── Dialog ───────────────────────────────────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surfaceContainerHigh,
        surfaceTintColor: colorScheme.surfaceTint,
        elevation: 3,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
        ),
        contentTextStyle: TextStyle(
          color: colorScheme.onSurfaceVariant,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
      ),

      // ── Snack Bar ─────────────────────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: TextStyle(color: colorScheme.onInverseSurface),
        actionTextColor: colorScheme.inversePrimary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
      ),

      // ── Badge ─────────────────────────────────────────────────────────────
      badgeTheme: BadgeThemeData(
        backgroundColor: colorScheme.error,
        textColor: colorScheme.onError,
        textStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        smallSize: 8,
        largeSize: 18,
      ),

      // ── Switch ────────────────────────────────────────────────────────────
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return colorScheme.onPrimary;
          return colorScheme.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return colorScheme.primary;
          return colorScheme.surfaceContainerHighest;
        }),
        trackOutlineColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return Colors.transparent;
          return colorScheme.outline;
        }),
      ),

      // ── Checkbox ──────────────────────────────────────────────────────────
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return colorScheme.primary;
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(colorScheme.onPrimary),
        side: BorderSide(color: colorScheme.outline, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),

      // ── Radio ─────────────────────────────────────────────────────────────
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return colorScheme.primary;
          return colorScheme.onSurfaceVariant;
        }),
      ),

      // ── Tab Bar ───────────────────────────────────────────────────────────
      tabBarTheme: TabBarThemeData(
        labelColor: colorScheme.primary,
        unselectedLabelColor: colorScheme.onSurfaceVariant,
        labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        indicatorColor: colorScheme.primary,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: colorScheme.outlineVariant.withValues(alpha: 0.5),
        splashFactory: InkRipple.splashFactory,
      ),

      // ── Icon ─────────────────────────────────────────────────────────────
      iconTheme: IconThemeData(color: colorScheme.onSurface),

      // ── FAB ──────────────────────────────────────────────────────────────
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
        elevation: 2,
        focusElevation: 4,
        hoverElevation: 4,
        highlightElevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // ── Divider ───────────────────────────────────────────────────────────
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        thickness: 1,
        space: 1,
      ),

      // ── Popup Menu ────────────────────────────────────────────────────────
      popupMenuTheme: PopupMenuThemeData(
        color: colorScheme.surfaceContainer,
        elevation: 3,
        shadowColor: Colors.transparent,
        surfaceTintColor: colorScheme.surfaceTint,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        labelTextStyle: WidgetStateProperty.all(
          TextStyle(
            color: colorScheme.onSurface,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // ── Tooltip ───────────────────────────────────────────────────────────
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: colorScheme.inverseSurface,
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: TextStyle(
          color: colorScheme.onInverseSurface,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),

      // ── Scroll ────────────────────────────────────────────────────────────
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(
          colorScheme.onSurface.withValues(alpha: 0.2),
        ),
        trackColor: WidgetStateProperty.all(Colors.transparent),
        radius: const Radius.circular(8),
        thickness: WidgetStateProperty.all(4),
      ),

      // ── Splash / Ink ─────────────────────────────────────────────────────
      splashFactory: InkSparkle.splashFactory,
      splashColor: colorScheme.primary.withValues(alpha: 0.08),
      highlightColor: colorScheme.primary.withValues(alpha: 0.06),
    );
  }

  void _applySystemUiOverlay(bool isDark) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
        systemStatusBarContrastEnforced: false,
        systemNavigationBarContrastEnforced: false,
      ),
    );
  }

  Future<void> setWindowsTitleBarColor(Color color) async {
    if (!GetPlatform.isWindows) return;
    try {
      Future.delayed(
          const Duration(milliseconds: 350),
          () async => await platform.invokeMethod('setTitleBarColor', {
                'r': (color.r * 255).round().clamp(0, 255),
                'g': (color.g * 255).round().clamp(0, 255),
                'b': (color.b * 255).round().clamp(0, 255),
              }));
    } on PlatformException catch (e) {
      printERROR("Failed to set title bar color: ${e.message}");
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Color Extensions — kept for backwards compatibility with other files
// ─────────────────────────────────────────────────────────────────────────────

extension ColorWithHSL on Color {
  HSLColor get hsl => HSLColor.fromColor(this);

  Color withSaturation(double saturation) =>
      hsl.withSaturation(clampDouble(saturation, 0.0, 1.0)).toColor();

  Color withLightness(double lightness) =>
      hsl.withLightness(clampDouble(lightness, 0.0, 1.0)).toColor();

  Color withHue(double hue) =>
      hsl.withHue(clampDouble(hue, 0.0, 360.0)).toColor();
}

extension ComplementaryColor on Color {
  Color get complementaryColor => getComplementaryColor(this);
  Color getComplementaryColor(Color color) {
    return Color.from(
        alpha: color.a,
        red: 1.0 - color.r,
        green: 1.0 - color.g,
        blue: 1.0 - color.b);
  }
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${(a * 255).round().toRadixString(16).padLeft(2, '0')}'
      '${(r * 255).round().toRadixString(16).padLeft(2, '0')}'
      '${(g * 255).round().toRadixString(16).padLeft(2, '0')}'
      '${(b * 255).round().toRadixString(16).padLeft(2, '0')}';
}

enum ThemeType {
  dynamic,
  system,
  dark,
  light,
}
