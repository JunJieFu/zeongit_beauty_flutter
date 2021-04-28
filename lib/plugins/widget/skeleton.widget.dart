import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Skeleton extends StatefulWidget {
  Skeleton({Key key, this.height = 20, this.width = 200}) : super(key: key);
  final double height;
  final double width;

  createState() => SkeletonState();
}

class SkeletonState extends State<Skeleton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);

    _animation = Tween<double>(
      begin: -3,
      end: 10,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    )..addListener(() {
        setState(() {});
      });

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(_animation.value, 0),
              end: Alignment(-1, 0),
              colors: [Colors.black12, Colors.white12, Colors.black12])),
    );
  }
}
