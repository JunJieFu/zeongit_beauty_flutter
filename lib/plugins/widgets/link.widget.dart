import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Link extends StatelessWidget {
  Link(this.text, {Key key, this.onTap}) : super(key: key);

  final String text;

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(color: primaryColor),
      ),
    );
  }
}
