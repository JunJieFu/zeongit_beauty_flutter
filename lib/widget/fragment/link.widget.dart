import 'package:flutter/cupertino.dart';
import 'package:zeongitbeautyflutter/assets/style/index.style.dart';

class LinkWidget extends StatelessWidget {
  LinkWidget(
      this.text, {
        Key key,
      }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: StyleConfig.primaryColor),
    );
  }
}
