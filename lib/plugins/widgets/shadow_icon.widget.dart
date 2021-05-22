import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShadowIcon extends StatelessWidget {
  ShadowIcon(this.icon,
      {Key? key, required this.color, this.size, this.boxShadow})
      : super(key: key);

  final IconData icon;

  final Color color;

  final double? size;

  final BoxShadow? boxShadow;

  final _iconTheme = IconTheme.of(Get.context!);

  @override
  Widget build(BuildContext context) {
    return Text(String.fromCharCode(icon.codePoint),
        style: TextStyle(
            color: color,
            fontFamily: icon.fontFamily,
            fontSize: size ?? _iconTheme.size,
            shadows: [
              boxShadow ??
                  BoxShadow(
                      color: Colors.black87,
                      offset: Offset(0.1, .5),
                      blurRadius: 3.0)
            ]));
  }
}
