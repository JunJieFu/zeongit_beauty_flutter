import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/plugins/constants/key.constant.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/utils/storage.util.dart';
import 'package:zeongitbeautyflutter/plugins/utils/theme.util.dart';

class ThemeLogic extends GetxController {
  final _primaryColor = Rx(Color(
      (StorageManager.get<int?>(KeyConstant.PRIMARY_COLOR) ??
          StyleConfig.primaryColor.value)));

  Color get primaryColor => _primaryColor.value;

  getTheme({bool? isDark, Color? color}) {
    final _isDark =
        isDark ?? (StorageManager.getBool(KeyConstant.IS_DARK) ?? false);
    final _color = color ??
        Color((StorageManager.get<int?>(KeyConstant.PRIMARY_COLOR) ??
            StyleConfig.primaryColor.value));
    return _isDark ? darkThemeData(_color) : lightThemeData(_color);
  }

  changeTheme({bool? isDark, Color? color}) {
    final _isDark =
        isDark ?? (StorageManager.getBool(KeyConstant.IS_DARK) ?? false);
    final _color = color ??
        Color((StorageManager.get<int?>(KeyConstant.PRIMARY_COLOR) ??
            StyleConfig.primaryColor.value));
    Get.changeTheme(getTheme(isDark: _isDark, color: _color));
    StorageManager.setBool(KeyConstant.IS_DARK, _isDark);
    StorageManager.setInt(KeyConstant.PRIMARY_COLOR, _color.value);
    _primaryColor.value = _color;
  }
}
