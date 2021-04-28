import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';

class ChipsTextFieldWidget extends StatefulWidget {
  ChipsTextFieldWidget(
      {Key key,
      this.controller,
      this.autofocus = false,
      this.obscureText = false,
      this.decoration = const InputDecoration()})
      : super(key: key);

  final TextEditingController controller;
  final bool autofocus;
  final bool obscureText;
  final InputDecoration decoration;

  @override
  ChipsTextFieldWidgetState createState() => ChipsTextFieldWidgetState();
}

class ChipsTextFieldWidgetState extends State<ChipsTextFieldWidget> {
  FocusNode focusNode = FocusNode();
  bool hasFocus = false;
  List<String> valueList = ["123", "123"];

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: widget.controller,
      autofocus: widget.autofocus,
      obscureText: widget.obscureText,
      cursorColor: StyleConfig.primaryColor,
      decoration: widget.decoration.copyWith(
          icon: Wrap(
              children: valueList
                  .map((e) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Chip(label: Text(e)),
                      ))
                  .toList())),
    );
  }
}
