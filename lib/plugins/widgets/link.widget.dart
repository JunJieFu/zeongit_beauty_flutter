import 'package:flutter/cupertino.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';

class Link extends StatelessWidget {
  Link(this.text, {Key key, this.onTap}) : super(key: key);

  final String text;

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(color: StyleConfig.primaryColor),
      ),
    );
  }
}
