import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Link extends StatelessWidget {
  Link(this.text, {Key? key, this.onTap}) : super(key: key);

  final String text;

  final GestureTapCallback? onTap;

  final primaryColor = Get.theme.primaryColor;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(color: primaryColor),
      ),
    );
  }
}
