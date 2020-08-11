import 'package:flutter/cupertino.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';

class TextWidget extends StatelessWidget {
  TextWidget(
    this.text, {
    Key key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: StyleConfig.textColor),
    );
  }
}
