import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: AspectRatio(
          aspectRatio: 1,
          child: ClipOval(
              child: SvgPicture.asset('assets/images/default-head.svg'))),
      onPressed: () {},
    );
  }
}
