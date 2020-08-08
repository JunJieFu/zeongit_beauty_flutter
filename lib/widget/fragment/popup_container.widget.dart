import 'package:flutter/material.dart';

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
      assert(textDirection != null);
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
  final Widget _child;

  PopupContainerRoute({
    @required Widget child,
  }) : _child = child;

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Duration get transitionDuration => Duration(milliseconds: 0);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _child;
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}

class PopupContainer extends StatefulWidget {
  const PopupContainer({
    Key key,
    this.child,
    this.duration = const Duration(milliseconds: 300),
    this.onForward,
    this.onDismissed,
    this.onReverse,
    this.onCompleted,
    this.targetRenderKey,
    this.offset = Offset.zero,
  }) : super(key: key);

  final Widget child;

  final Duration duration;

  final Function onForward;

  final Function onDismissed;

  final Function onReverse;

  final Function onCompleted;

  final GlobalKey targetRenderKey;

  final Offset offset;

  @override
  State<StatefulWidget> createState() => _PopupContainerState();
}

class _PopupContainerState extends State<PopupContainer>
    with SingleTickerProviderStateMixin {
  Animation<Offset> animation;
  AnimationController _controller;

  ///收起弹框
  ///popup window dismiss
  Future _dismiss(BuildContext context) async {
    await _controller.reverse();
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _controller.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.forward:
          if (widget.onForward != null) {
            widget.onForward();
          }
          break;
        case AnimationStatus.dismissed:
          if (widget.onDismissed != null) {
            widget.onDismissed();
          }
          break;
        case AnimationStatus.reverse:
          if (widget.onReverse != null) {
            widget.onReverse();
          }
          break;
        case AnimationStatus.completed:
          if (widget.onCompleted != null) {
            widget.onCompleted();
          }
          break;
      }
    });
    _controller.forward();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final RenderBox button =
        widget.targetRenderKey.currentContext.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(widget.targetRenderKey.currentContext)
        .context
        .findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(widget.offset, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                child: GestureDetector(
                  child: Container(
                    color: Colors.transparent,
                  ),
                  onTap: () {
                    _dismiss(context);
                  },
                ),
              ),
              CustomSingleChildLayout(
                delegate: _PopupWindowRouteLayout(
                  position,
                  Directionality.of(widget.targetRenderKey.currentContext),
                ),
                child: FadeTransition(
                  opacity: Tween(begin: 0.0, end: 1.0).animate(_controller),
                  child: widget.child,
                ),
              )
            ],
          ),
        ),
        onWillPop: () {
          _dismiss(context);
          return Future.value(false);
        });
  }
}

