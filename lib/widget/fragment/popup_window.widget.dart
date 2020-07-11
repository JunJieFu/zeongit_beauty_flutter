import 'package:flutter/material.dart';

class PopupWindow extends StatefulWidget {
  const PopupWindow(
      {Key key,
      this.child,
      this.duration = const Duration(milliseconds: 300),
      this.onForward,
      this.onDismissed,
      this.onReverse,
      this.onCompleted,
      this.targetRenderBox,
      this.offsetX = 0,
      this.offsetY = 0})
      : super(key: key);

  final Widget child;

  final Duration duration;

  final Function onForward;

  final Function onDismissed;

  final Function onReverse;

  final Function onCompleted;

  final RenderBox targetRenderBox;

  final double offsetX;

  final double offsetY;

  @override
  State<StatefulWidget> createState() => _PopupWindowState();
}

class _PopupWindowState extends State<PopupWindow>
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
    Offset targetOffset = widget.targetRenderBox.localToGlobal(Offset.zero);
    Size targetSize = widget.targetRenderBox.size;
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
              Positioned(
                left: targetOffset.dx - (0 - targetSize.width) + widget.offsetX,
                top: targetOffset.dy - (0 - targetSize.height) + widget.offsetY,
                child: FadeTransition(
                  opacity: Tween(begin: 0.0, end: 1.0).animate(_controller),
                  child: widget.child,
                ),
              )
            ],
          ),
        ),
        onWillPop: () {
          return Future.value(false);
        });
  }
}
