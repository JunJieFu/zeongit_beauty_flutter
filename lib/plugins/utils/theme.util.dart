import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/plugins/utils/color.util.dart';

final _defaultLightThemeData = ThemeData();
final _defaultDarkThemeData = ThemeData(brightness: Brightness.dark);

lightThemeData(Color color) {
  return ThemeData(
      brightness: Brightness.light,
      accentColor: lighten(color, 0.08),
      platform: TargetPlatform.android,
      primaryColor: color,
      primaryColorBrightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: _defaultLightThemeData.scaffoldBackgroundColor,
      bottomAppBarColor: _defaultLightThemeData.scaffoldBackgroundColor,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.white,
          foregroundColor: color,
          elevation: 6,
          highlightElevation: 6),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: color)),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        primary: color,
      )),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              primary: color, side: BorderSide(color: color))),
      chipTheme: ChipThemeData(
          backgroundColor: _defaultLightThemeData.chipTheme.backgroundColor,
          disabledColor: _defaultLightThemeData.chipTheme.disabledColor,
          selectedColor: _defaultLightThemeData.chipTheme.selectedColor,
          secondarySelectedColor:
              _defaultLightThemeData.chipTheme.secondarySelectedColor,
          labelPadding: _defaultLightThemeData.chipTheme.labelPadding,
          padding: _defaultLightThemeData.chipTheme.padding,
          shape: _defaultLightThemeData.chipTheme.shape,
          labelStyle: _defaultLightThemeData.chipTheme.labelStyle,
          secondaryLabelStyle:
              _defaultLightThemeData.chipTheme.secondaryLabelStyle,
          brightness: _defaultLightThemeData.chipTheme.brightness,
          elevation: 0,
          pressElevation: 0),
      appBarTheme: AppBarTheme(
          elevation: 1,
          backgroundColor: _defaultLightThemeData.scaffoldBackgroundColor),
      tabBarTheme: TabBarTheme(
        labelColor: color,
        unselectedLabelColor: Colors.black45,
      ),
      colorScheme: ColorScheme.light(
        primary: color,
      ));
}

darkThemeData(Color color) {
  return ThemeData(
      brightness: Brightness.dark,
      accentColor: lighten(color, 0.08),
      platform: TargetPlatform.android,
      primaryColor: color,
      primaryColorBrightness: Brightness.dark,
      bottomAppBarColor: _defaultDarkThemeData.scaffoldBackgroundColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: color)),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        primary: color,
      )),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              primary: color, side: BorderSide(color: color))),
      chipTheme: ChipThemeData(
          backgroundColor: _defaultDarkThemeData.chipTheme.backgroundColor,
          disabledColor: _defaultDarkThemeData.chipTheme.disabledColor,
          selectedColor: _defaultDarkThemeData.chipTheme.selectedColor,
          secondarySelectedColor:
              _defaultDarkThemeData.chipTheme.secondarySelectedColor,
          labelPadding: _defaultDarkThemeData.chipTheme.labelPadding,
          padding: _defaultDarkThemeData.chipTheme.padding,
          shape: _defaultDarkThemeData.chipTheme.shape,
          labelStyle: _defaultDarkThemeData.chipTheme.labelStyle,
          secondaryLabelStyle:
              _defaultDarkThemeData.chipTheme.secondaryLabelStyle,
          brightness: _defaultDarkThemeData.chipTheme.brightness,
          elevation: 0,
          pressElevation: 0),
      appBarTheme: AppBarTheme(
          elevation: 1,
          backgroundColor: _defaultDarkThemeData.scaffoldBackgroundColor),
      tabBarTheme: TabBarTheme(
        labelColor: color,
        unselectedLabelColor: Colors.white54,
      ),
      colorScheme: ColorScheme.dark(
          surface: Colors.transparent,
          primary: color,
          onPrimary: Colors.white));
}
