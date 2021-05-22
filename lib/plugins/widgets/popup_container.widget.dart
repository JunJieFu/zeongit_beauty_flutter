import 'package:flutter/material.dart';
import 'package:get/get.dart';

const double _kWindowScreenPadding = 8.0;

class _PopupWindowRouteLayout extends SingleChildLayoutDelegate {
  _PopupWindowRouteLayout(this.position, this.textDirection);

  final RelativeRect position;

  final TextDirection textDirection;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(
      constraints.biggest -
          const Offset(
              _kWindowScreenPadding * 2.0, _kWindowScreenPadding * 2.0) as Size,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double y = position.top;

    double x;
    if (position.left > position.right) {
      x = size.width - position.right - childSize.width;
    } else if (position.left < position.right) {
      x = position.left;
    } else {
      switch (textDirection) {
        case TextDirection.rtl:
          x = size.width - position.right - childSize.width;
          break;
        case TextDirection.ltr:
          x = position.left;
          break;
      }
    }

    if (x < _kWindowScreenPadding)
      x = _kWindowScreenPadding;
    else if (x + childSize.width > size.width - _kWindowScreenPadding)
      x = size.width - childSize.width - _kWindowScreenPadding;
    if (y < _kWindowScreenPadding)
      y = _kWindowScreenPadding;
    else if (y + childSize.height > size.height - _kWindowScreenPadding)
      y = size.height - childSize.height - _kWindowScreenPadding;
    return Offset(x, y);
  }

  @override
  bool shouldRelayout(_PopupWindowRouteLayout oldDelegate) {
    return position != oldDelegate.position ||
        textDirection != oldDelegate.textDirection;
  }
}

class PopupContainerRoute extends PopupRoute {
  final Widget child;

  PopupContainerRoute({
    required this.child,
  });

  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Duration get transitionDuration => Duration(milliseconds: 200);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
      child: child,
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}

class PopupContainer extends StatelessWidget {
  const PopupContainer({
    Key? key,
    required this.child,
    required this.targetRenderKey,
    this.offset = Offset.zero,
  }) : super(key: key);

  final Widget child;

  final GlobalKey targetRenderKey;

  final Offset offset;

  @override
  Widget build(BuildContext context) {
    final RenderBox button =
        targetRenderKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(targetRenderKey.currentContext!)!
        .context
        .findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(offset, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              Positioned(
                child: GestureDetector(
                  child: Container(
                    color: Colors.transparent,
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
              CustomSingleChildLayout(
                delegate: _PopupWindowRouteLayout(
                  position,
                  Directionality.of(targetRenderKey.currentContext!),
                ),
                child: child,
              )
            ],
          ),
        ),
        onWillPop: () {
          Get.back();
          return Future.value(false);
        });
  }
}
