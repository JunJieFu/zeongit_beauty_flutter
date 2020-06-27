import 'package:flutter/material.dart';

class UserWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.all(0),
      icon: Container(
        child: AspectRatio(
            aspectRatio: 1,
            child: ClipOval(
                child: Image(
                    image: AssetImage('assets/images/welcome.jpg'),
                    fit: BoxFit.cover))),
      ),
      onPressed: () {},
    );
  }
}
