import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/plugins/constants/key.constant.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/utils/storage.util.dart';

class ThemeGetxCtrl extends GetxController {
  final _primaryColor = Rx<Color>(StyleConfig.primaryColor);

  final _isDark  =  (StorageManager.get<bool>(KeyConstant.IS_DARK) ?? false).obs;

  Color get primaryColor => _primaryColor.value;

  bool get isDark => _isDark.value;


  updatePrimaryColor(Color color) {
    _primaryColor.value = color;
  }

  updateTheme() {
    StorageManager.setBool(KeyConstant.IS_DARK, !_isDark.value);
    _isDark.value = !_isDark.value;
  }
}
