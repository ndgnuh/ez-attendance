import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:material_ui/material_ui.dart';

abstract final class AppTheme {
  static final subThemesData = FlexSubThemesData(
    blendOnColors: true,
    inputDecoratorIsFilled: true,
    alignedDropdown: true,
    defaultRadius: 8,
    useMaterial3Typography: true,
    searchUseGlobalShape: true,
  );

  static final colorScheme = FlexScheme.blue;
  static final iconTheme = const IconThemeData(fill: 0.0);

  static ThemeData dark = FlexThemeData.dark(
    scheme: colorScheme,
    subThemesData: subThemesData,
    keyColors: const FlexKeyColors(),
  ).copyWith(iconTheme: iconTheme);

  static ThemeData light = FlexThemeData.light(
    scheme: colorScheme,
    subThemesData: subThemesData,
    keyColors: const FlexKeyColors(),
  ).copyWith(iconTheme: iconTheme);
}
