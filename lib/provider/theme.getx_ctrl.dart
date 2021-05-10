import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/plugins/constants/key.constant.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/utils/storage.util.dart';

class ThemeGetxCtrl extends GetxController {
  final _primaryColor = Rx<Color>(Color(
      (StorageManager.get<int>(KeyConstant.PRIMARY_COLOR) ??
          StyleConfig.primaryColor.value)));

  final _isDark = (StorageManager.get<bool>(KeyConstant.IS_DARK) ?? false).obs;

  Color get primaryColor => _primaryColor.value;

  bool get isDark => _isDark.value;

  updatePrimaryColor(Color color) {
    StorageManager.setInt(KeyConstant.PRIMARY_COLOR, color.value);
    _primaryColor.value = color;
  }

  updateTheme() {
    StorageManager.setBool(KeyConstant.IS_DARK, !_isDark.value);
    _isDark.toggle();
  }
}
