import 'package:flutter/material.dart';

///闪屏
class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Image(
            image: AssetImage('assets/images/splash.png'), fit: BoxFit.cover));
  }
}
