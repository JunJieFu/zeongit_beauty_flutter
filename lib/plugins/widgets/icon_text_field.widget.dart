import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/plugins/hooks/focus_node.hook.dart';

class IconTextField extends HookWidget {
  IconTextField(
      {Key? key,
      required this.controller,
      this.obscureText = false,
      required this.hintText,
      required this.icon})
      : super(key: key);

  final TextEditingController controller;
  final bool obscureText;
  final String hintText;
  final IconData icon;
  final _primaryColor = Get.theme.primaryColor;
  final _hasFocus = false.obs;

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNodeObs(_hasFocus);
    return TextField(
      focusNode: focusNode,
      controller: controller,
      obscureText: obscureText,
      cursorColor: _primaryColor,
      decoration: InputDecoration(
        isDense: false,
        focusColor: _primaryColor,
        prefixIcon: Obx(
            () => Icon(icon, color: _hasFocus.value ? _primaryColor : null)),
        hintText: hintText,
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: _primaryColor)),
      ),
    );
  }
}
