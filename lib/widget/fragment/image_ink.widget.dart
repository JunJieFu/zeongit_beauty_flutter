import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageInkWidget extends StatelessWidget {
  const ImageInkWidget(
      {Key key, this.child, this.constrained = false, this.onTap})
      : super(key: key);

  final Widget child;

  final bool constrained;

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      constrained
          ? ConstrainedBox(
              child: child,
              constraints: new BoxConstraints.expand(),
            )
          : child,
      Positioned.fill(
          child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
        ),
      ))
    ]);
  }
}
