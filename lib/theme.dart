import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _aniFlowBlue = Color(0xFF1DA2E5);

abstract final class AniFlowTypography {
  static const family = 'BeVietnamPro';
}

/// Geometry shared by app chrome and reusable cards.
abstract final class AniFlowRadii {
  static const posterCard = 20.0;
  static const landscapeCard = 24.0;
  static const mediaPanel = 14.0;
  static const card = 32.0;
  static const modal = 40.0;
  static const pill = 999.0;
}

/// Layout rhythm used by top-level app sections.
abstract final class AniFlowSpacing {
  static const railGap = 12.0;
  static const pageHorizontal = 16.0;
  static const cardContent = 16.0;
  static const sectionGap = 24.0;
}

/// App-specific semantic colors that do not belong in Material ColorScheme.
@immutable
class AniFlowSemanticColors extends ThemeExtension<AniFlowSemanticColors> {
  const AniFlowSemanticColors({this.newContentBadge = const Color(0xFFD32F2F)});

  final Color newContentBadge;

  @override
  AniFlowSemanticColors copyWith({Color? newContentBadge}) =>
      AniFlowSemanticColors(
        newContentBadge: newContentBadge ?? this.newContentBadge,
      );

  @override
  AniFlowSemanticColors lerp(covariant AniFlowSemanticColors? other, double t) {
    if (other == null) return this;
    return AniFlowSemanticColors(
      newContentBadge: Color.lerp(newContentBadge, other.newContentBadge, t)!,
    );
  }
}

/// Playback surfaces stay dark regardless of the app ThemeMode so controls keep
/// predictable contrast over video, embeds and fullscreen transitions.
@immutable
class AniFlowMediaColors extends ThemeExtension<AniFlowMediaColors> {
  const AniFlowMediaColors({
    this.viewport = const Color(0xFF000000),
    this.foreground = const Color(0xFFFFFFFF),
    this.foregroundMuted = const Color(0xB3FFFFFF),
    this.accent = _aniFlowBlue,
    this.settingsSurface = const Color(0xEB000000),
    this.settingsBorder = const Color(0x24FFFFFF),
    this.divider = const Color(0x1FFFFFFF),
    this.tabActiveSurface = const Color(0x24FFFFFF),
    this.sliderInactive = const Color(0x4DFFFFFF),
    this.hudSurface = const Color(0xB8000000),
    this.controlSurface = const Color(0xA6000000),
    this.scrimTop = const Color(0xD9000000),
    this.scrimCenter = const Color(0x0D000000),
    this.scrimBottom = const Color(0xE6000000),
  });

  final Color viewport;
  final Color foreground;
  final Color foregroundMuted;
  final Color accent;
  final Color settingsSurface;
  final Color settingsBorder;
  final Color divider;
  final Color tabActiveSurface;
  final Color sliderInactive;
  final Color hudSurface;
  final Color controlSurface;
  final Color scrimTop;
  final Color scrimCenter;
  final Color scrimBottom;

  @override
  AniFlowMediaColors copyWith({
    Color? viewport,
    Color? foreground,
    Color? foregroundMuted,
    Color? accent,
    Color? settingsSurface,
    Color? settingsBorder,
    Color? divider,
    Color? tabActiveSurface,
    Color? sliderInactive,
    Color? hudSurface,
    Color? controlSurface,
    Color? scrimTop,
    Color? scrimCenter,
    Color? scrimBottom,
  }) => AniFlowMediaColors(
    viewport: viewport ?? this.viewport,
    foreground: foreground ?? this.foreground,
    foregroundMuted: foregroundMuted ?? this.foregroundMuted,
    accent: accent ?? this.accent,
    settingsSurface: settingsSurface ?? this.settingsSurface,
    settingsBorder: settingsBorder ?? this.settingsBorder,
    divider: divider ?? this.divider,
    tabActiveSurface: tabActiveSurface ?? this.tabActiveSurface,
    sliderInactive: sliderInactive ?? this.sliderInactive,
    hudSurface: hudSurface ?? this.hudSurface,
    controlSurface: controlSurface ?? this.controlSurface,
    scrimTop: scrimTop ?? this.scrimTop,
    scrimCenter: scrimCenter ?? this.scrimCenter,
    scrimBottom: scrimBottom ?? this.scrimBottom,
  );

  @override
  AniFlowMediaColors lerp(covariant AniFlowMediaColors? other, double t) {
    if (other == null) return this;
    return AniFlowMediaColors(
      viewport: Color.lerp(viewport, other.viewport, t)!,
      foreground: Color.lerp(foreground, other.foreground, t)!,
      foregroundMuted: Color.lerp(foregroundMuted, other.foregroundMuted, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      settingsSurface: Color.lerp(settingsSurface, other.settingsSurface, t)!,
      settingsBorder: Color.lerp(settingsBorder, other.settingsBorder, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      tabActiveSurface: Color.lerp(
        tabActiveSurface,
        other.tabActiveSurface,
        t,
      )!,
      sliderInactive: Color.lerp(sliderInactive, other.sliderInactive, t)!,
      hudSurface: Color.lerp(hudSurface, other.hudSurface, t)!,
      controlSurface: Color.lerp(controlSurface, other.controlSurface, t)!,
      scrimTop: Color.lerp(scrimTop, other.scrimTop, t)!,
      scrimCenter: Color.lerp(scrimCenter, other.scrimCenter, t)!,
      scrimBottom: Color.lerp(scrimBottom, other.scrimBottom, t)!,
    );
  }
}

extension AniFlowThemeContext on BuildContext {
  AniFlowSemanticColors get aniFlowColors =>
      Theme.of(this).extension<AniFlowSemanticColors>() ??
      const AniFlowSemanticColors();

  AniFlowMediaColors get aniFlowMediaColors =>
      Theme.of(this).extension<AniFlowMediaColors>() ??
      const AniFlowMediaColors();
}

ThemeData aniFlowTheme() => _buildAniFlowTheme(_aniFlowLightScheme());

ThemeData aniFlowDarkTheme() => _buildAniFlowTheme(_aniFlowDarkScheme());

ColorScheme _aniFlowLightScheme() =>
    ColorScheme.fromSeed(seedColor: _aniFlowBlue).copyWith(
      primary: _aniFlowBlue,
      onPrimary: const Color(0xFF001F2D),
      primaryContainer: const Color(0xFFCBEAFF),
      onPrimaryContainer: const Color(0xFF001E2E),
      secondary: const Color(0xFF3E6478),
      onSecondary: const Color(0xFFFFFFFF),
      secondaryContainer: const Color(0xFFCBE8F7),
      onSecondaryContainer: const Color(0xFF0A1F2B),
      tertiary: const Color(0xFF466477),
      onTertiary: const Color(0xFFFFFFFF),
      tertiaryContainer: const Color(0xFFCCE8F7),
      onTertiaryContainer: const Color(0xFF0B1E2A),
      surface: const Color(0xFFF8FAFC),
      surfaceContainerLow: const Color(0xFFF3F7FA),
      surfaceContainer: const Color(0xFFEDF2F6),
      surfaceContainerHigh: const Color(0xFFE6ECF1),
      surfaceContainerHighest: const Color(0xFFDEE6EC),
      onSurface: const Color(0xFF000000),
      onSurfaceVariant: const Color(0xFF46515A),
      outline: const Color(0xFF717D86),
      outlineVariant: const Color(0xFFC5CDD3),
      inverseSurface: const Color(0xFF263238),
      onInverseSurface: const Color(0xFFF2F7FA),
      inversePrimary: const Color(0xFF82CDF4),
      error: const Color(0xFFB3261E),
      onError: const Color(0xFFFFFFFF),
      errorContainer: const Color(0xFFF9DEDC),
      onErrorContainer: const Color(0xFF410E0B),
    );

ColorScheme _aniFlowDarkScheme() =>
    ColorScheme.fromSeed(
      seedColor: _aniFlowBlue,
      brightness: Brightness.dark,
    ).copyWith(
      primary: _aniFlowBlue,
      onPrimary: const Color(0xFF001F2D),
      primaryContainer: const Color(0xFF004C6C),
      onPrimaryContainer: const Color(0xFFC6E9FF),
      secondary: const Color(0xFF93C9E6),
      onSecondary: const Color(0xFF103344),
      secondaryContainer: const Color(0xFF254B5E),
      onSecondaryContainer: const Color(0xFFC9EAFB),
      tertiary: const Color(0xFFA3C9DD),
      onTertiary: const Color(0xFF183442),
      tertiaryContainer: const Color(0xFF314F5E),
      onTertiaryContainer: const Color(0xFFD2EBF7),
      surface: const Color(0xFF000000),
      surfaceContainerLow: const Color(0xFF0A0A0A),
      surfaceContainer: const Color(0xFF121212),
      surfaceContainerHigh: const Color(0xFF1A1A1A),
      surfaceContainerHighest: const Color(0xFF222222),
    );

ThemeData _buildAniFlowTheme(ColorScheme scheme) => ThemeData(
  useMaterial3: true,
  brightness: scheme.brightness,
  colorScheme: scheme,
  fontFamily: AniFlowTypography.family,
  textTheme: _aniFlowTextTheme(scheme.brightness),
  extensions: const <ThemeExtension<dynamic>>[
    AniFlowSemanticColors(),
    AniFlowMediaColors(),
  ],
  scaffoldBackgroundColor: scheme.surface,
  appBarTheme: AppBarTheme(
    backgroundColor: scheme.surface,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    scrolledUnderElevation: 0,
    toolbarHeight: 64,
  ),
  navigationBarTheme: NavigationBarThemeData(
    height: 80,
    backgroundColor: scheme.surfaceContainer,
    indicatorColor: scheme.secondaryContainer,
  ),
  cardTheme: CardThemeData(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AniFlowRadii.card),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: scheme.surfaceContainerHigh,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AniFlowRadii.pill),
      borderSide: BorderSide.none,
    ),
  ),
  dialogTheme: DialogThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AniFlowRadii.modal),
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AniFlowRadii.modal),
      ),
    ),
  ),
);

TextTheme _aniFlowTextTheme(Brightness brightness) {
  final base = ThemeData(
    useMaterial3: true,
    brightness: brightness,
  ).textTheme.apply(fontFamily: AniFlowTypography.family);

  return base.copyWith(
    displayLarge: base.displayLarge?.copyWith(
      fontWeight: FontWeight.w700,
      letterSpacing: -0.6,
      height: 1.08,
    ),
    displayMedium: base.displayMedium?.copyWith(
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      height: 1.1,
    ),
    displaySmall: base.displaySmall?.copyWith(
      fontWeight: FontWeight.w700,
      letterSpacing: -0.4,
      height: 1.12,
    ),
    headlineLarge: base.headlineLarge?.copyWith(
      fontWeight: FontWeight.w700,
      letterSpacing: -0.3,
      height: 1.14,
    ),
    headlineMedium: base.headlineMedium?.copyWith(
      fontWeight: FontWeight.w700,
      letterSpacing: -0.2,
      height: 1.16,
    ),
    headlineSmall: base.headlineSmall?.copyWith(
      fontWeight: FontWeight.w700,
      letterSpacing: -0.1,
      height: 1.18,
    ),
    titleLarge: base.titleLarge?.copyWith(
      fontWeight: FontWeight.w600,
      letterSpacing: -0.1,
      height: 1.2,
    ),
    titleMedium: base.titleMedium?.copyWith(
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.22,
    ),
    titleSmall: base.titleSmall?.copyWith(
      fontWeight: FontWeight.w600,
      letterSpacing: 0.05,
      height: 1.24,
    ),
    bodyLarge: base.bodyLarge?.copyWith(
      fontWeight: FontWeight.w400,
      letterSpacing: 0.1,
      height: 1.4,
    ),
    bodyMedium: base.bodyMedium?.copyWith(
      fontWeight: FontWeight.w400,
      letterSpacing: 0.1,
      height: 1.4,
    ),
    bodySmall: base.bodySmall?.copyWith(
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      height: 1.38,
    ),
    labelLarge: base.labelLarge?.copyWith(
      fontWeight: FontWeight.w600,
      letterSpacing: 0.1,
      height: 1.2,
    ),
    labelMedium: base.labelMedium?.copyWith(
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      height: 1.2,
    ),
    labelSmall: base.labelSmall?.copyWith(
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
      height: 1.2,
    ),
  );
}

ThemeData aniFlowMediaTheme(ThemeData base) {
  final media =
      base.extension<AniFlowMediaColors>() ?? const AniFlowMediaColors();
  return base.copyWith(
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: media.foreground),
    ),
    sliderTheme: base.sliderTheme.copyWith(
      activeTrackColor: media.accent,
      thumbColor: media.accent,
      inactiveTrackColor: media.sliderInactive,
    ),
    progressIndicatorTheme: base.progressIndicatorTheme.copyWith(
      color: media.accent,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: media.accent),
    ),
  );
}

/// Persisted user preference. Kept separate from visual token definitions above.
class ThemeModePreferences {
  static const key = 'aniflow.settings.themeMode.v1';

  Future<ThemeMode> load() async {
    final preferences = await SharedPreferences.getInstance();
    final value = preferences.getString(key);
    if (value == 'dark') return ThemeMode.dark;
    if (value != 'light') await preferences.setString(key, 'light');
    return ThemeMode.light;
  }

  Future<void> save(ThemeMode mode) async {
    await (await SharedPreferences.getInstance()).setString(
      key,
      mode == ThemeMode.dark ? 'dark' : 'light',
    );
  }
}
