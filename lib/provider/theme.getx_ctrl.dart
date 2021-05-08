import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/utils/color.util.dart';

final _defaultLightThemeData = ThemeData(scaffoldBackgroundColor: Colors.white);
final _defaultDarkThemeData = ThemeData(brightness: Brightness.dark);

class ThemeGetxCtrl extends GetxController {
  final _primaryColor = Rx<Color>(StyleConfig.primaryColor);

  Color get primaryColor => _primaryColor.value;

  ThemeData get light => ThemeData(
      brightness: Brightness.light,
      accentColor: lighten(_primaryColor.value, 0.08),
      platform: TargetPlatform.android,
      primaryColor: _primaryColor.value,
      primaryColorBrightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: _defaultLightThemeData.scaffoldBackgroundColor,
      bottomAppBarColor: _defaultLightThemeData.scaffoldBackgroundColor,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.white,
          foregroundColor: _primaryColor.value,
          elevation: 6,
          highlightElevation: 6),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: _primaryColor.value)),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        primary: _primaryColor.value,
      )),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              primary: _primaryColor.value,
              side: BorderSide(color: _primaryColor.value))),
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
        labelColor: _primaryColor.value,
        unselectedLabelColor: Colors.black45,
      ));

  ThemeData get dark => ThemeData(
      brightness: Brightness.dark,
      accentColor: lighten(_primaryColor.value, 0.08),
      platform: TargetPlatform.android,
      primaryColor: _primaryColor.value,
      primaryColorBrightness: Brightness.dark,
      bottomAppBarColor: _defaultDarkThemeData.scaffoldBackgroundColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: _primaryColor.value)),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        primary: _primaryColor.value,
      )),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              primary: _primaryColor.value,
              side: BorderSide(color: _primaryColor.value))),
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
        labelColor: _primaryColor.value,
        unselectedLabelColor: Colors.white54,
      ));

  updatePrimaryColor(Color color) {
    _primaryColor.value = color;
  }
}
