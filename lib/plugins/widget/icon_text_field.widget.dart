
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';

class IconTextField extends StatefulWidget {
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
  _IconTextFieldState createState() => _IconTextFieldState();
}

class _IconTextFieldState extends State<IconTextField> {
  FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;

  @override
  void initState() {
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      controller: widget.controller,
      obscureText: widget.obscureText,
      cursorColor: StyleConfig.primaryColor,
      decoration: InputDecoration(
        isDense: false,
        focusColor: StyleConfig.primaryColor,
        prefixIcon: Icon(widget.icon,
            color: _hasFocus ? StyleConfig.primaryColor : null),
        hintText: widget.hintText,
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: StyleConfig.primaryColor)),
      ),
    );
  }
}