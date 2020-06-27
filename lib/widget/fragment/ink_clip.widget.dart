import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InkClipWidget extends StatelessWidget {
  const InkClipWidget(
      {Key key, this.size = 100, this.padding = 8, this.child, this.onTap})
      : super(key: key);

  final double size;

  final double padding;

  final Widget child;

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: size,
      height: size,
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(size / 2)),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: ClipOval(
            child: child,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
