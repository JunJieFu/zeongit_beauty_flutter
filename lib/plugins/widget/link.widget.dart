import 'package:flutter/cupertino.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';

class LinkWidget extends StatelessWidget {
  LinkWidget(this.text, {Key key, this.onTap}) : super(key: key);

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
