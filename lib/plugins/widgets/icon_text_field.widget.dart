import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';

class IconTextField extends HookWidget {
  IconTextField(
      {Key key,
      this.controller,
      this.obscureText = false,
      this.hintText,
      this.icon})
      : super(key: key);

  final TextEditingController controller;
  final bool obscureText;
  final String hintText;
  final IconData icon;

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
      cursorColor: StyleConfig.primaryColor,
      decoration: InputDecoration(
        isDense: false,
        focusColor: StyleConfig.primaryColor,
        prefixIcon:
            Icon(icon, color: hasFocus.value ? StyleConfig.primaryColor : null),
        hintText: hintText,
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: StyleConfig.primaryColor)),
      ),
    );
  }
}
