
import 'package:flutter/cupertino.dart';

class TitleWidget extends StatelessWidget {
  TitleWidget(
      this.text, {
        Key key,
      }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, textScaleFactor: 1.5);
  }
}