import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class Skeleton extends HookWidget {
  Skeleton({Key key, this.height = 20, this.width = 200}) : super(key: key);
  final double height;
  final double width;

  final _isDark = Get.theme.brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    var controller =
        useAnimationController(duration: Duration(milliseconds: 1500));
    var animation = useAnimation(Tween<double>(
      begin: -3,
      end: 10,
    ).animate(
      CurvedAnimation(parent: controller, curve: Curves.linear),
    ));
    controller.repeat();

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(animation, 0),
              end: Alignment(-1, 0),
              colors: _isDark
                  ? [Colors.white24, Colors.black12, Colors.white24]
                  : [Colors.black12, Colors.white12, Colors.black12])),
    );
  }
}
