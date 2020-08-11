import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class ShadowIconWidget extends StatelessWidget {
  ShadowIconWidget(this.icon, {Key key, this.color, this.size, this.boxShadow})
      : super(key: key);

  final IconData icon;

  final Color color;

  final double size;

  final BoxShadow boxShadow;

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    return Text(String.fromCharCode(icon.codePoint),
        style: TextStyle(
            color: color,
            fontFamily: icon.fontFamily,
            fontSize: size ?? iconTheme.size,
            shadows: [
              boxShadow ??
                  BoxShadow(
                      color: Colors.black87,
                      offset: Offset(0.1, .5),
                      blurRadius: 3.0)
            ]));
  }
}
