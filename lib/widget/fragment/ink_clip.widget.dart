import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InkClipWidget extends StatefulWidget {
  const InkClipWidget(
      {Key key, this.size = 100, this.padding = 8, this.child, this.onTap})
      : super(key: key);

  final double size;

  final double padding;

  final Widget child;

  final GestureTapCallback onTap;

  @override
  State<StatefulWidget> createState() => _InkClipWidgetState();
}

class _InkClipWidgetState extends State<InkClipWidget> {
  @override
  Widget build(BuildContext context) {
    return Ink(
      width: widget.size,
      height: widget.size,
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(widget.size / 2)),
        child: Padding(
          padding: EdgeInsets.all(widget.padding),
          child: ClipOval(
            child: widget.child,
          ),
        ),
        onTap: widget.onTap,
      ),
    );
  }
}
