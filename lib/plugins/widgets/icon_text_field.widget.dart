import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

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

  @override
  Widget build(BuildContext context) {
    var focusNode = useFocusNode();
    var hasFocus = useState(false);
    focusNode.addListener(() {
      hasFocus.value = focusNode.hasFocus;
    });
    return TextField(
      focusNode: focusNode,
      controller: controller,
      obscureText: obscureText,
      cursorColor: _primaryColor,
      decoration: InputDecoration(
        isDense: false,
        focusColor: _primaryColor,
        prefixIcon: Icon(icon, color: hasFocus.value ? _primaryColor : null),
        hintText: hintText,
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: _primaryColor)),
      ),
    );
  }
}
