import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/assets/style/index.style.dart';

class ImageInkWidget extends StatelessWidget {
  const ImageInkWidget(
      {Key key,
      this.child,
      this.constrained = false,
      this.borderRadius,
      this.onTap})
      : super(key: key);

  final Widget child;

  final bool constrained;

  final GestureTapCallback onTap;

  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      constrained
          ? ConstrainedBox(
              child: child,
              constraints: BoxConstraints.expand(),
            )
          : ClipRRect(
              borderRadius: BorderRadius.all(
                  Radius.circular(borderRadius ?? StyleConfig.listGap)),
              child: child),
      Positioned.fill(
          child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius:
              BorderRadius.circular(borderRadius ?? StyleConfig.listGap),
          onTap: onTap,
        ),
      ))
    ]);
  }
}
