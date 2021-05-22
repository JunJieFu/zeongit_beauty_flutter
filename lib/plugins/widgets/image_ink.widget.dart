import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';

class ImageInk extends StatelessWidget {
  const ImageInk(
      {Key? key,
      required this.child,
      this.constrained = false,
      this.borderRadius,
      required this.onTap,
      this.onLongPress})
      : super(key: key);

  final Widget child;

  final bool constrained;

  final GestureTapCallback onTap;

  final GestureLongPressCallback? onLongPress;

  final double? borderRadius;

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
                  Radius.circular(borderRadius ?? StyleConfig.pictureRadius)),
              child: child),
      Positioned.fill(
          child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius:
              BorderRadius.circular(borderRadius ?? StyleConfig.pictureRadius),
          onTap: onTap,
          onLongPress: onLongPress,
        ),
      ))
    ]);
  }
}
