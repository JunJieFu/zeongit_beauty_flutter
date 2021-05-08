import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/utils/color.util.dart';

final defaultThemeData = ThemeData();

class ThemeGetxCtrl extends GetxController {
  final _primaryColor = Rx<Color>(StyleConfig.primaryColor);

  Color get primaryColor => _primaryColor.value;

  ThemeData get light => ThemeData(
      accentColor: lighten(_primaryColor.value, 0.08),
      platform: TargetPlatform.android,
      scaffoldBackgroundColor: Colors.white,
      primaryColor: _primaryColor.value,
      primaryColorBrightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
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
          backgroundColor: defaultThemeData.chipTheme.backgroundColor,
          disabledColor: defaultThemeData.chipTheme.disabledColor,
          selectedColor: defaultThemeData.chipTheme.selectedColor,
          secondarySelectedColor:
              defaultThemeData.chipTheme.secondarySelectedColor,
          labelPadding: defaultThemeData.chipTheme.labelPadding,
          padding: defaultThemeData.chipTheme.padding,
          shape: defaultThemeData.chipTheme.shape,
          labelStyle: defaultThemeData.chipTheme.labelStyle,
          secondaryLabelStyle: defaultThemeData.chipTheme.secondaryLabelStyle,
          brightness: defaultThemeData.chipTheme.brightness,
          elevation: 0,
          pressElevation: 0),
      appBarTheme: AppBarTheme(elevation: 1, backgroundColor: Colors.white),
      tabBarTheme: TabBarTheme(
        labelColor: _primaryColor.value,
        unselectedLabelColor: Colors.black45,
      ));

  updatePrimaryColor(Color color) {
    _primaryColor.value = color;
  }
}
